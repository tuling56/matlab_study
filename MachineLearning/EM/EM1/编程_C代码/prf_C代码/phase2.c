/*--- removing excessive flow - second phase of PR-algorithm */
void prefl_to_flow ( )
/*
   do dsf in the reverse flow graph from nodes with excess
   cancel cycles if found
   return excess flow in topological order
*/

/*
   rank is used for dfs labels
   nl_prev is used for DSF tree
   nl_next is used for topological order list
*/
{
  node *i, *j, *tos, *bos, *restart, *r;
  arc *a;
  long delta;

  /* deal with self-loops */
  for ( i = nodes; i < nodes + n; i++ ) {
    for ( a = i -> first; a != NULL; a = a -> next )
      if ( a -> head == i ) {
	a -> r_cap = cap[a - arcs];
      }
  }

  /* initialize */
  bos = NULL;
  for ( i = nodes; i < nodes + n; i++ ) {
    i -> rank = WHITE;
    i -> nl_prev = NULL;
    i -> current = i -> first;
  }

  for ( i = nodes; i < nodes + n; i++ )
    if (( i -> rank == WHITE ) && ( i -> excess > 0 ) &&
	( i != source ) && ( i != sink )) {
      r = i;
      r -> rank = GREY;
      do {
	for ( ; i -> current != NULL; i -> current = i -> current -> next ) {
	  a = i -> current;
	  if (( cap[a - arcs] == 0 ) && ( a -> r_cap > 0 ) &&
	      ( a -> head != source) && ( a -> head != sink )) {
	    j = a -> head;
	    if ( j -> rank == WHITE ) {
	      /* start scanning j */
	      j -> rank = GREY;
	      j -> nl_prev = i;
	      i = j;
	      break;
	    }
	    else
	      if ( j -> rank == GREY ) {
		/* find minimum flow on the cycle */
		delta = a -> r_cap;
		while ( 1 ) {
		  delta = MIN ( delta, j -> current -> r_cap );
		  if ( j == i )
		    break;
		  else
		    j = j -> current -> head;
		}

		/* remove delta flow units */
		j = i;
		while ( 1 ) {
		  a = j -> current;
		  a -> r_cap -= delta;
		  a -> sister -> r_cap += delta;
		  j = a -> head;
		  if ( j == i )
		    break;
		}
	
		/* back DFS to the first zerod arc */
		restart = i;
		for ( j = i -> current -> head; j != i; j = a -> head ) {
		  a = j -> current;
		  if (( j -> rank == WHITE ) || ( a -> r_cap == 0 )) {
		    j -> current -> head -> rank = WHITE;
		    if ( j -> rank != WHITE )
		      restart = j;
		  }
		}
	
		if ( restart != i ) {
		  i = restart;
		  i -> current = i -> current -> next;
		  break;
		}
	      }
	  }
	}

	if ( i -> current == NULL ) {
	  /* scan of i complete */
	  i -> rank = BLACK;
	  if ( i != source ) {
	    if ( bos == NULL ) {
	      bos = i;
	      tos = i;
	    }
	    else {
	      i -> nl_next = tos;
	      tos = i;
	    }
	  }

	  if ( i != r ) {
	    i = i -> nl_prev;
	    i -> current = i -> current -> next;
	  }
	  else
	    break;
	}
      } while ( 1 );
    }


  /* return excesses */
  /* note that sink is not on the stack */
  if ( bos != NULL ) {
    i = tos;
    do {
      a = i -> first;
      while ( i -> excess > 0 ) {
	if (( cap[a - arcs] == 0 ) && ( a -> r_cap > 0 )) {
	  delta = MIN ( i -> excess, a -> r_cap );
	  a -> r_cap -= delta;
	  a -> sister -> r_cap += delta;
	  i -> excess -= delta;
	  a -> head -> excess += delta;
	}
	a = a -> next;
      }
      if ( i == bos )
	break;
      else
	i = i -> nl_next;
    } while ( 1 );
  }
}

