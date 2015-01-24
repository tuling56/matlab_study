/* defs.h */

typedef  /* arc */
   struct arc_st
{
   long             r_cap;           /* residual capasity */
   struct node_st   *head;           /* head */
   struct arc_st    *sister;         /* opposite arc */
   struct arc_st    *next;           /* next arc with the same tail */
}
  arc;

typedef  /* node */
   struct node_st
{
   arc              *first;           /* first outgoing arc */
   arc              *current;         /* current incident arc */
   struct node_st   *previous;        /* previous node in the path to sink */
   long             rank;             /* distance from the sink */
} node;
