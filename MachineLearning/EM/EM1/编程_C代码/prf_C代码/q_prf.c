/* Maximal flow - Push-Relabel algorithm */
/* Queue with gap and global updates */
/* Boris Cherkassky - cher@theory.stanford.edu, on.cher@zib-berlin.de */
/* Andrew V. Goldberg - goldberg@cs.stanford.edu */

#define BIGGEST_FLOW MAXLONG
#define MIN( a, b ) ( ( (a) < (b) ) ? a : b )
#define GLOB_UPDT_FREQ 1
#define WHITE 0
#define GREY 1
#define BLACK 2

#define FLOW(a) ( cap[a - arcs] - a -> r_cap )

/* global variables */

long   n;                    /* number of nodes */
node   *nodes;               /* array of nodes */
arc    *arcs;                /* array of arcs */
layer  *layers;              /* array of layers */
long   *cap;                 /* array of capasities */
node   *source;              /* origin */
node   *sink;                /* destination */
node   **queue;              /* queue for storing nodes */
node   **q_read, **q_write;  /* queue pointers */
long   lmax;                 /* maximal layer */
node   *qp_first, *qp_last;  /* beg and end of push-queue */

/*--- initialization */

int pr_init ( n_p, nodes_p, arcs_p, cap_p, source_p, sink_p )

long    n_p;       /* number of nodes */
node    *nodes_p;  /* array of nodes */
arc     *arcs_p;   /* array of arcs */
long    *cap_p;    /* array of capasitiies */
node    *source_p; /* origin          */
node    *sink_p;   /* destination     */

{
node  *i;        /* current node */

n      = n_p;
nodes  = nodes_p;
arcs   = arcs_p;
cap    = cap_p;
source = source_p;
sink   = sink_p;

queue = (node**) calloc ( n, sizeof (node*) );
if ( queue == NULL ) return ( 1 );

layers = (layer*) calloc ( n+2, sizeof (layer) );
if ( layers == NULL ) return ( 1 );

for ( i = nodes; i < nodes + n; i++ )
  i -> excess = 0;

source -> excess = BIGGEST_FLOW;

lmax = n-1;

return ( 0 );

} /* end of initialization */


/*--- global rank update - breadth first search */

void def_ranks ()

{

node  *i, *j, *jn;  /* current nodes */
arc   *a;           /* current arc   */
layer *l;           /* current layer */
long  j_rank;       /* rank of node j */

n_up ++; /* statistics */

/* initialization */

for ( i = nodes; i < nodes + n; i ++ )
  i    -> rank = n;

  sink -> rank = 0;

*queue = sink;

qp_first = qp_last = NULL;

for ( l = layers; l <= layers + lmax; l++ )
  {
    l -> first   = NULL;
  }

lmax = 0;

/* breadth first search */

for ( q_read = queue, q_write = queue + 1; 
      q_read != q_write;
      q_read ++
    )
   { /* scanning arcs incident to node i */

    i = *q_read;
    j_rank = ( i -> rank ) + 1;

    for ( a = i -> first; a != NULL; a = a -> next )
      {
        j = a -> head;

        if ( j -> rank == n )
          /* j is not labelled */

          if ( ( ( a -> sister ) -> r_cap ) > 0 )
    	{ /* arc (j, i) is not saturated */

    	  j -> rank    = j_rank;
    	  j -> current = j -> first;

	  l = layers + j_rank;
	  if ( j_rank > lmax ) lmax = j_rank;

	  if ( ( j -> excess ) > 0 )
	    {
	      j -> q_next     = qp_first;
	      if ( qp_first == NULL ) qp_last = j;
	      qp_first        = j;
	    }

	      jn = l -> first;
	      j -> nl_next     = jn;
	      if ( jn != NULL )
		jn -> nl_prev = j;
	      l -> first  = j; 


    	  *q_write = j; q_write ++; /* put j  to scanning queue */
    	}
      } /* node "i" is scanned */ 
  } /* end of scanning queue */

} /* end of global update */

#include "phase2.c"

/*--- cleaning beyond the gap */

int gap ( le )

layer *le;        /* pointer to the empty layer */

{

layer *l;          /* current layer */
node  *i;          /* current nodes */
long  r;           /* rank of the layer before l  */
int   cc;          /* cc = 1 - no nodes with positive excess before
		      the gap */

n_gap ++; /* statistics */

r = ( le - layers ) - 1;

/* putting ranks beyond the gap to "infinity" */

for ( l = le + 1; l <= layers + lmax; l ++ )
  {
    for ( i = l -> first; i != NULL; i = i -> nl_next )
{
      i -> rank = n;
n_gnode ++; /* statistics */     
}

    l -> first = NULL;
  }

cc =  0;

lmax = r;

return ( cc );

} /* end of gap */


/*--- pushing flow from node  i  */

int push ( i )

node  *i;      /* outpushing node */

{

node  *j;                /* sucsessor of i */
node  *j_next, *j_prev;  /* j's sucsessor and predecessor in layer list */
long  j_rank;            /* rank of the next layer */
layer *lj;               /* j's layer */
arc   *a;                /* current arc (i,j) */
long  fl;                /* flow to push through the arc */

j_rank = (i -> rank) - 1;

/* scanning arcs outgoing from  i  */

for ( a = i -> current; a != NULL; a = a -> next )
  {
    if ( a -> r_cap > 0 ) /* "a" is not saturated */
      {
	j = a -> head;

	if ( j -> rank == j_rank ) 
	  { /* j belongs to the next layer */

	    fl = MIN ( i -> excess, a -> r_cap );

	    a             -> r_cap -= fl;
	    (a -> sister) -> r_cap += fl;
n_push ++; /* statistics */

	    if ( j_rank > 0 )
	      {
		lj = layers + j_rank;

		if ( j -> excess == 0 )
		  { /* before current push  j  had zero excess */
		
		    /* put  j  to the push-list */

		    if ( qp_first != NULL )
			qp_last -> q_next = j;
		    else
			qp_first = j;


		    qp_last = j;
		    j -> q_next = NULL;

		  } /* j -> excess == 0 */

	      } /* j -> rank > 0 */

	    j -> excess += fl;
	    i -> excess -= fl;

	    if ( i -> excess == 0 ) break;

	  } /* j belongs to the next layer */
      } /* a  is not saturated */
  } /* end of scanning arcs from  i */

i -> current = a;

return ( ( a == NULL ) ? 1 : 0 );

} /* end of push */

/*--- relabelling node i */

long relabel ( i )

node *i;   /* node to relabel */

{

node  *j;        /* sucsessor of i */
long  j_rank;    /* minimal rank of a node available from j */
arc   *a;        /* current arc */
arc   *a_j;      /* an arc which leads to the node with minimal rank */
layer *l;        /* layer for node i */

n_rel ++; /* statistics */

i -> rank = j_rank = n;

/* looking for a node with minimal rank available from i */

for ( a = i -> first; a != NULL; a = a -> next )
  {
    if ( a -> r_cap > 0 )
      {
	j = a -> head;

	if ( j -> rank < j_rank )
	  {
	    j_rank = j -> rank;
	    a_j    = a;
	  }
      }
  }
      
j_rank++;
if ( j_rank < n )
  {
    /* siting  i  into the manual */

    i -> rank    = j_rank;
    i -> current = a_j;

    l = layers + j_rank;

    j = l -> first;
    i -> nl_next = j;
    if ( j != NULL ) j -> nl_prev = i;
    l -> first = i;

    if ( j_rank > lmax ) lmax = j_rank;

  } /* end of j_rank < n */

return ( j_rank );

} /* end of relabel */


/*--- organizer */

int prflow ( n_p, nodes_p, arcs_p, cap_p, source_p, sink_p, fl )

long   n_p;         /* number of nodes */
node   *nodes_p;    /* array of nodes */
arc    *arcs_p;     /* array of arcs  */
long   *cap_p;      /* capasity */
node   *source_p;   /* origin */
node   *sink_p;     /* destination */
double *fl;         /* flow amount*/

{

node   *i;          /* current node */
node   *j, *jn;     /* i-neighbors in layer list */
long   i_rank;      /* rank of  i */
layer  *l;          /* current layer */
long   n_r;         /* the number of relabels */
int    cc;          /* condition code */

int ii=0;

cc = pr_init ( n_p, nodes_p, arcs_p, cap_p, source_p, sink_p );

if ( cc ) return ( cc );

def_ranks ();

n_r = 0;

/* queue method */

while ( qp_first != NULL ) /* main loop */
  { 
    /* checking the necessity of global update */
    if ( n_r > GLOB_UPDT_FREQ * (float) n ) 
      { /* it is time for global update */
	def_ranks ();
	n_r = 0;
	if ( qp_first == NULL ) break;
      }

    i = qp_first;
    qp_first = qp_first -> q_next;
    if ( qp_first == NULL ) qp_last = NULL;

    i_rank = i -> rank;

    while ( i_rank < n ) 
      {
        /* untill i will be free from excess or beyond the gap */
	l = layers + i_rank;

	cc = push ( i );
	if ( cc == 0 ) break;

	/* i must be relabeled */

	/* remove  i  from the layer */
	jn = i -> nl_next;

	if ( i == l -> first )
	     l -> first = jn;
	else
	  {
	    j  = i -> nl_prev;
	    j -> nl_next = jn;
	    if ( jn != NULL ) jn -> nl_prev = j;
	  }

	    i_rank = relabel ( i );
	    n_r ++;

            if ( l -> first == NULL )
	      { /* gap is found */
                gap ( l );
		i_rank = i -> rank;
	      }

      } /* end of scanning i */

  } /* end of the main loop */
    
*fl += sink -> excess;

t2 = timer() - t2;

prefl_to_flow ( );

return ( 0 );

} /* end of constructing flow */

