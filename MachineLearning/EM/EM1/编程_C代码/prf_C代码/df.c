/* Maximal flow - Dinitz algorithm */
/* 01/09/94 - Stanford Computer Science Department */
/* Boris Cherkassky - cher@theory.stanford.edu, on.cher@zib-berlin.de */
/* Andrew V. Goldberg - goldberg@cs.stanford.edu */

#define BIGGEST_FLOW MAXLONG

int dflow ( n, nodes, arcs, source, sink, fl )

long   n;        /* number of nodes */
node   *nodes;   /* array of nodes */
arc    *arcs;    /* array of arcs  */
node   *source;  /* origin */
node   *sink;    /* destination */
double *fl;      /* flow */

{
node *i, *j, *min_i;                 /* current nodes */
node **queue, **q_read, **q_write;   /* queue for constructing manual */
arc  *a;                             /* current arcs */
long j_rank;                         /* temporary variables */
long min_cap;
int  cut;


/* ------- initialization ------------ */

queue = (node**) calloc ( n, sizeof (node*) );

if ( queue == NULL ) return ( 1 );

for ( i = nodes; i < nodes + n; i ++ )
  i    -> rank = n;

  sink -> rank = 0;

sink -> previous = NULL;
*queue = sink;

/* ------- main loop : ---------------------------
         - constructing manual;
         - constructing flow in the manual
----------------------------------------------- */

while ( 1 )
  {
    for ( q_read = queue, q_write = queue + 1, cut = 1; 
	  q_read != q_write && cut != 0;
          q_read ++
        )
       { /* scanning arcs incident to node i */
	i = *q_read;
	for ( a = i -> first; a != NULL; a = a -> next )
	  {
	    j = a -> head;

	    if ( j -> rank == n )
	      /* j is not labelled */

	      if ( ( ( a -> sister ) -> r_cap ) > 0 )
		{ /* arc (j, i) is not saturated */

		  j -> rank = ( i -> rank ) + 1;

		  j -> current = j -> first;

		  *q_write = j; q_write ++;

		  if ( j == source )
		    { cut = 0; break; }
		}
	  } /* node "i" is scanned */ 
      } /* end of scanning queue */

    if ( cut != 0 ) break;  /* cut is found - max flow is constructed */

    i = source;

    while ( 1 )
      { /* until there is a path from the source to the sink
	   in the manual */

	while ( i != sink && i != NULL )
	  { /* looking for a path in the manual from the source 
	       to the sink, starting from node i */

            for ( a = i -> current, j_rank = ( i -> rank ) - 1; 
		  a != NULL; 
		  a = a -> next
		)
	       /* scanning arcs from node i */
	       if ( ( ( a -> head ) -> rank == j_rank ) && ( a -> r_cap ) > 0 )
	              /* j is in the next layer of the manual 
	        	 and arc (i,j) is not saturated */
			 break;
	    
	    i -> current = a;

	    if ( a != NULL )
	      { /* step forward */
		j = a -> head;
		j -> previous = i;
		i = j;
	      }
	    else 
	        /* step back */
	      {
		i = i -> previous;
		if ( i != NULL )
		  i -> current = ( i -> current ) -> next;
	      }
	  } /* end of looking for a path */

	if ( i == NULL ) break; /* manual is saturated */

	min_cap = BIGGEST_FLOW;
	
	for ( i = source; i != sink; i = a -> head )
	  { /* finding path capasity */

	    a = i -> current;
	    if ( ( a -> r_cap ) < min_cap )
	      {
		min_i   = i;
		min_cap = a -> r_cap;
	      }
	  }

	for ( i = source; i != sink; i = a -> head )
	  { /* changing flows */
	    a = i -> current;
	    a             -> r_cap -= min_cap;
	    (a -> sister) -> r_cap += min_cap;
	  }

	*fl += (double) min_cap;

	/* next path would start from min_i */
	i = min_i;

      }	/* current manual is done */

    /* restoring ranks */
    for ( q_read = queue + 1; q_read < q_write; q_read ++ )
      (*q_read) -> rank = n;

  } /* end of main loop */

return 0;

}
