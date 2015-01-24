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
   long             excess;           /* excess of the node */
   long             rank;             /* distance from the sink */
   struct node_st   *nl_next;         /* next node in layer-list */
   struct node_st   *nl_prev;         /* previous node in layer-list */
   struct node_st   *q_next;          /* next node in queue */
} node;


typedef /* layer */
   struct layer_st
{
   node             *first;            /* 1st node in the layer */
} layer;
