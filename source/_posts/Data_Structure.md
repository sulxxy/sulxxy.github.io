title: Data Structure
date: 2016-02-14 14:28:03
categories: Study Notes
tags: [Data Structure]
---

Linear lists
===
Array implementation
---
1. Static allocation:
	{% codeblock %}	
		typedef struct Array_Node{
			ElemType m[SIZE];     //the capacity of the list
			unsigned int length;  //the length of the list
		}Array_Node, *P_Array_Node;
	{% endcodeblock %}
<!-- more -->
2. Dynamic allocation:
	{% codeblock %}	
		typedef struct{
			ElemType m*;
			unsigned int length;
			unsigned int size;
		}Array_Node, *P_Array_Node;
	{% endcodeblock %}

Linked list 
---
1. ADT(Abstract Data Types)
	{% codeblock %}	
		typedef struct Linked_Node{
			ElemType m;
			struct Linked_Node* next;
		}Node, *PNode;
	{% endcodeblock %}
2. Polynomial ADT
	{% codeblock %}	
		typedef struct{
			float coef;
			int expn;
		}term, *ElemType;
		
		typedef struct LNODE{
			ElemType elem;
			struct LNODE* next;
		}*polynomial;
	{% endcodeblock %}

Stack & Queue
===
1. Stack: Last In First Out(LIFO)
	
	* Implementation: Push and pop the stack at the header of a linked list
		{% codeblock %}	
			typedef struct{
				ElemType elem;
				struct Node* next;
			}Node, *P_Node;
		{% endcodeblock %}
	* Application:
		* Balancing symbols
		* Postfix expressions
2. Queue: First In First Out(FIFO)
	{% codeblock %}	
		typedef struct{
			ElemType elem;
			struct QNode* next;
		}QNode, *QNodePtr;
		
		typedef struct{
			QNodePtr front;
			QNodePtr tail;
		}LinkedQueue;
	{% endcodeblock %}

String(Pass)
===
Array(Pass)
===
Tree
===
ADT of Binary Tree
---
{% codeblock %}	
	typedef struct{
		ElemType elem;
		struct TNode* lchild;
		struct TNode* rchild;
	}TNode, *TNodePtr;
{% endcodeblock %}

Tree traversals
---
1. Preorder traversal(D-L-R)
	In a preorder traversal, work at a node is performed before (pre) its children are processed.
	{% codeblock %}	
		void preorder(TNode* root){
			if(!root){
				return OVER;
			}else{
				print(root->elem);
				preorder(root->lchild);
				preorder(root->rchild);
			}
		} 
	{% endcodeblock %}

2. Inorder traversal(L-D-R)
	{% codeblock %}	
		void inorder(TNode* root){
			if(!root){
				return OVER;
			}else{
				inorder(root->lchild);
				print(root->elem);
				inorder(root->rchild);
			}
		}
	{% endcodeblock %}

3. Postorder traversal(L-R-D)
	{% codeblock %}	
		void postorder(TNode* root){
			if(!root){
				return OVER;
			}else{
				postorder(root->lchild);
				postorder(root->rchild);
				print(root->elem);
			}
		}
	{% endcodeblock %}

Huffman tree
---
1. ADT
	{% codeblock %}	
		typedef struct{
			char ch;
			unsigned float weight;
			unsigned int parent, lchild, rchild;
		}TNode, *HuffmanTree;
	{% endcodeblock %}

2. Huffman codes
	* Encoding
		{% codeblock %}	
			void encoding(HuffmanTree &HC,HuffmanCode HC[], int n, int *w){
				initNode();
				buildTree();
				get_HuffmanCode_In_Reversed_Order();
			}
		{% endcodeblock %}
	* Decoding
		{% codeblock %}	
			void decoding(){
				while(read_a_bit_from_input_stream() != NULL){
					enter_left_OR_right_branch();
					if(the_branch->lchild == NULL && the_branch_rchild == NULL){
						print(the_branch->ch);
						goto_the_root_of_the_tree();
					}
				}
			}
		{% endcodeblock %}

Graph
===
Representations of a graph
---
1. Adjacent matrix
	{% codeblock lang:C %}	
		typedef double AdjMatrix[Vex_Max][Arc_Max];
		
		typedef struct{
			int vexnum, arcnum;
			AdjMatrix arc;
		}Graph;
	{% endcodeblock %}
	
2. Adjacent list
	{% codeblock %}	
		typedef struct{
			int vexID;
			double weight;
			struct ArcNode* next_arc;
		}ArcNode;
		
		typedef struct{
			VertexType data;
			ArcNode* first_arc;
		}AdjList[Max_Vex_Num];
			
		typedef struct{
			int vexnum, arcnum;
			AdjList vertices;
		}Graph;
	{% endcodeblock %}
	
Traversals of a graph
---
1. DFS(Depth First Search)
	
	Recursion;

2. BFS(Breadth First Search)
	
	Queue;

Minimum spanning tree
---
1. Prim algorithm
2. Kruskal algorithm

Shortest path
---
1. Dijkstra algorithm
	
	Dijkstra is a computer scientist.

Search
===
Statically searching
---
1. Unsorted list
	
	Strategy: search one by one

2. Sorted list
	
	Strategy: binary search

Dynamically searching
---
	
	Binary searching tree


Hashing
---
Sort
===

