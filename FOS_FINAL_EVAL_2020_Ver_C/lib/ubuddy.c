#include <inc/lib.h>

/* This file is dedicated for implementing the BUDDY system
 * inside the user heap
 */

struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
	node->level = 0;
	node->status = FREE;
	node->va = 0;
	node->parent = NULL;
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}

/*===============================================================*/

void CreateNewBuddySpace()
{
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");

}

void* FindAllocationUsingBuddy(int size)
{
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
}

void FreeAllocationUsingBuddy(uint32 va)
{
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");

}
/*===============================================================*/
void* lastAlloc = (void*) USER_HEAP_START ;
void* __new(uint32 size)
{
	void* va = lastAlloc;
	size = ROUNDUP(size, PAGE_SIZE) ;
	sys_new((uint32)va, size) ;
	lastAlloc += size ;
	return va ;
}
