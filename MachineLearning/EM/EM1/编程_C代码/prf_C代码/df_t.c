/*               Executor of MF codes                      */
/*               (for Dinitz)                              */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "values.h"

/* definitions of types: node & arc */

#include "types_df.h"

/* parser for getting extended DIMACS format input and transforming the
   data to the internal representation */

#include "parser_fl.c"

/* function 'timer()' for mesuring processor time */

#include "timer.c"

/* function for constructing maximal flow */

#include "df.c"

main ( argc, argv )

int   argc;
char *argv[];

{

float t;
arc *arp, *a;
long *cap;
node *ndp, *source, *sink, *i;
long n, m, nmin; 
long ni, na;
double flow = 0;
int  cc, prt;

prt     = ( argc > 1 ) ? atoi( argv[1] ): 1;

#define N_NODE( i ) ( (i) - ndp + nmin )
#define N_ARC( a )  ( ( a == NULL )? -1 : (a) - arp )

printf("c\nc maxflow - Dinits algorithm\nc\n");

parse( &n, &m, &ndp, &arp, &cap, &source, &sink, &nmin );

printf("c nodes: %10ld\nc arcs:  %10ld\nc\n", n, m);

t = timer();
cc = dflow ( n, ndp, arp, source, sink, &flow );
t = timer() - t;

if ( cc ) { fprintf ( stderr, "Allocating error\n"); exit ( 1 ); }

printf ("c time:  %10.2f\nc flow:  %10.0lf\nc\n", t, flow );

if ( prt > 1 )
  {
    printf ("s %.0lf\n", flow);

    for ( i = ndp; i < ndp + n; i ++ )
      {
	ni = N_NODE(i);
	for ( a = i -> first; a != NULL; a = a -> next )
	  {
	    na = N_ARC(a);
	    if ( cap[na] - (a -> r_cap) > 0 )
	      printf ( "f %7ld %7ld %12ld\n",
		      ni, N_NODE( a -> head ), cap[na] - ( a -> r_cap )
		      );
	  }
      }
    printf("c\n");
  }
}
