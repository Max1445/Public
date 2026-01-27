Alright 👍
Below is a **solid, clean, exam-oriented notes** on **Priority Queue**, covering **all important points**, with **definitions, syntax, tables, and facts** — no comments, no explanations fluff.

---

# PRIORITY QUEUE — COMPLETE NOTES

---

## 1. Definition

A **Priority Queue** is an Abstract Data Type in which each element is associated with a priority and elements are removed based on priority rather than insertion order.

---

## 2. Characteristics

* Each element has a priority
* Element with highest priority is deleted first
* FIFO order is followed for elements with same priority

---

## 3. Types of Priority Queue

1. Max Priority Queue
2. Min Priority Queue

---

## 4. Priority Queue ADT Operations

| Operation        | Description                     |
| ---------------- | ------------------------------- |
| create           | Create empty priority queue     |
| insert(x, p)     | Insert element with priority    |
| delete / extract | Remove highest priority element |
| peek             | Return highest priority element |
| isEmpty          | Check if queue is empty         |
| size             | Return number of elements       |

---

## 5. Implementation Methods

* Binary Heap
* Array
* Linked List
* Balanced Binary Search Tree

---

## 6. C++ STL Priority Queue

### Header

```cpp
#include <queue>
```

---

## 7. Declaration

### Max Priority Queue

```cpp
priority_queue<int> pq;
```

### Min Priority Queue

```cpp
priority_queue<int, vector<int>, greater<int>> pq;
```

---

## 8. STL Member Functions

| Function | Purpose            |
| -------- | ------------------ |
| push(x)  | Insert element     |
| pop()    | Remove top element |
| top()    | Access top element |
| empty()  | Check if empty     |
| size()   | Number of elements |

---

## 9. Priority Queue with Pair

```cpp
priority_queue<pair<int,int>> pq;
```

---

## 10. Priority Queue with Custom Comparator

```cpp
struct Node {
    int data;
    int priority;
};
```

```cpp
struct compare {
    bool operator()(Node a, Node b) {
        return a.priority > b.priority;
    }
};
```

```cpp
priority_queue<Node, vector<Node>, compare> pq;
```

---

## 11. Time Complexity

| Operation | Time Complexity |
| --------- | --------------- |
| Insert    | O(log n)        |
| Delete    | O(log n)        |
| Peek      | O(1)            |

---

## 12. Space Complexity

O(n)

---

## 13. Limitations

* No direct priority update operation in STL
* Random access not allowed

---

## 14. Applications

* CPU scheduling
* Dijkstra’s shortest path algorithm
* Huffman coding
* Event-driven simulation
* Task scheduling

---

## 15. Key Points

* STL container: `priority_queue`
* Default behavior: Max Heap
* Underlying structure: Binary Heap
* Defined in `<queue>` header

---

# Implementation 
---
Yes — below is a **complete self-implemented Priority Queue in C++ as a template**, using a **binary heap**, similar to STL behavior.

This implementation supports:

* Generic data type (`template`)
* Max Priority Queue by default
* Custom comparator (can be Min PQ or user-defined)
* Core ADT operations

---

## Priority Queue Template Implementation (Binary Heap)

```cpp
#include <iostream>
#include <vector>
#include <stdexcept>
using namespace std;

template <typename T, typename Compare = less<T>>
class PriorityQueue {
private:
    vector<T> heap;
    Compare comp;

    int parent(int i) { return (i - 1) / 2; }
    int left(int i) { return 2 * i + 1; }
    int right(int i) { return 2 * i + 2; }

    void heapifyUp(int index) {
        while (index > 0 && comp(heap[parent(index)], heap[index])) {
            swap(heap[index], heap[parent(index)]);
            index = parent(index);
        }
    }

    void heapifyDown(int index) {
        int size = heap.size();
        int highest = index;

        int l = left(index);
        int r = right(index);

        if (l < size && comp(heap[highest], heap[l]))
            highest = l;

        if (r < size && comp(heap[highest], heap[r]))
            highest = r;

        if (highest != index) {
            swap(heap[index], heap[highest]);
            heapifyDown(highest);
        }
    }

public:
    PriorityQueue() {}

    bool empty() const {
        return heap.empty();
    }

    int size() const {
        return heap.size();
    }

    const T& top() const {
        if (empty())
            throw runtime_error("Priority Queue is empty");
        return heap[0];
    }

    void push(const T& value) {
        heap.push_back(value);
        heapifyUp(heap.size() - 1);
    }

    void pop() {
        if (empty())
            throw runtime_error("Priority Queue is empty");

        heap[0] = heap.back();
        heap.pop_back();
        if (!empty())
            heapifyDown(0);
    }

    void clear() {
        heap.clear();
    }
};
```

---

## Example Usage

### Max Priority Queue (Default)

```cpp
int main() {
    PriorityQueue<int> pq;

    pq.push(10);
    pq.push(30);
    pq.push(20);

    while (!pq.empty()) {
        cout << pq.top() << " ";
        pq.pop();
    }
}
```

**Output**

```
30 20 10
```

---

## Min Priority Queue

```cpp
int main() {
    PriorityQueue<int, greater<int>> pq;

    pq.push(10);
    pq.push(30);
    pq.push(20);

    while (!pq.empty()) {
        cout << pq.top() << " ";
        pq.pop();
    }
}
```

**Output**

```
10 20 30
```

---

## Custom Data Type Example

```cpp
struct Node {
    int data;
    int priority;
};

struct CompareNode {
    bool operator()(Node a, Node b) {
        return a.priority < b.priority;
    }
};

int main() {
    PriorityQueue<Node, CompareNode> pq;

    pq.push({1, 5});
    pq.push({2, 10});
    pq.push({3, 3});

    cout << pq.top().data;
}
```

---

## Time & Space Complexity

| Operation | Complexity |
| --------- | ---------- |
| push      | O(log n)   |
| pop       | O(log n)   |
| top       | O(1)       |
| space     | O(n)       |

---

## Features Covered

* Template-based generic design
* Binary heap implementation
* Custom comparator support
* STL-like interface
* Exception safety for empty access

---
---

This mirrors:

```cpp
std::priority_queue<T, Container, Compare>
```

---

# Full STL-Like `priority_queue` Implementation (Template)

### Features covered

* Template parameters: `T`, `Container`, `Compare`
* Default **max-heap**
* Constructors (default, range, copy)
* `push`, `emplace`
* `pop`, `top`
* `size`, `empty`
* `swap`
* Uses heap algorithms (`make_heap`, `push_heap`, `pop_heap`)
* STL-style naming & behavior

---

## Header File Implementation

```cpp
#include <vector>
#include <functional>
#include <algorithm>
#include <stdexcept>

template<
    class T,
    class Container = std::vector<T>,
    class Compare = std::less<typename Container::value_type>
>
class priority_queue {
public:
    using value_type      = T;
    using container_type  = Container;
    using size_type       = typename Container::size_type;
    using reference       = value_type&;
    using const_reference = const value_type&;

protected:
    container_type c;
    Compare comp;

public:
    /* Constructors */

    priority_queue()
        : c(), comp() {}

    explicit priority_queue(const Compare& compare)
        : c(), comp(compare) {}

    priority_queue(const Compare& compare, Container&& cont)
        : c(std::move(cont)), comp(compare) {
        std::make_heap(c.begin(), c.end(), comp);
    }

    template<class InputIterator>
    priority_queue(InputIterator first, InputIterator last,
                   const Compare& compare = Compare(),
                   Container cont = Container())
        : c(cont), comp(compare) {
        c.insert(c.end(), first, last);
        std::make_heap(c.begin(), c.end(), comp);
    }

    /* Capacity */

    bool empty() const {
        return c.empty();
    }

    size_type size() const {
        return c.size();
    }

    /* Element access */

    const_reference top() const {
        if (empty())
            throw std::out_of_range("priority_queue::top: empty");
        return c.front();
    }

    /* Modifiers */

    void push(const value_type& value) {
        c.push_back(value);
        std::push_heap(c.begin(), c.end(), comp);
    }

    void push(value_type&& value) {
        c.push_back(std::move(value));
        std::push_heap(c.begin(), c.end(), comp);
    }

    template<class... Args>
    void emplace(Args&&... args) {
        c.emplace_back(std::forward<Args>(args)...);
        std::push_heap(c.begin(), c.end(), comp);
    }

    void pop() {
        if (empty())
            throw std::out_of_range("priority_queue::pop: empty");
        std::pop_heap(c.begin(), c.end(), comp);
        c.pop_back();
    }

    void swap(priority_queue& other) noexcept {
        std::swap(c, other.c);
        std::swap(comp, other.comp);
    }

    /* Observers */

    Compare value_comp() const {
        return comp;
    }
};
```

---

## Usage Examples (Exactly Like STL)

### Max Priority Queue (Default)

```cpp
priority_queue<int> pq;

pq.push(10);
pq.push(30);
pq.push(20);

while (!pq.empty()) {
    std::cout << pq.top() << " ";
    pq.pop();
}
```

Output:

```
30 20 10
```

---

### Min Priority Queue

```cpp
priority_queue<int, std::vector<int>, std::greater<int>> pq;

pq.push(10);
pq.push(30);
pq.push(20);
```

---

### Custom Type + Comparator

```cpp
struct Node {
    int data;
    int priority;
};

struct CompareNode {
    bool operator()(const Node& a, const Node& b) const {
        return a.priority < b.priority;
    }
};

priority_queue<Node, std::vector<Node>, CompareNode> pq;
```

---

## STL Feature Parity Table

| Feature                 | Supported |
| ----------------------- | --------- |
| Template `T`            | ✅         |
| Container parameter     | ✅         |
| Comparator parameter    | ✅         |
| Max heap default        | ✅         |
| Min heap via comparator | ✅         |
| `push()`                | ✅         |
| `emplace()`             | ✅         |
| `pop()`                 | ✅         |
| `top()`                 | ✅         |
| `size()`                | ✅         |
| `empty()`               | ✅         |
| Range constructor       | ✅         |
| `swap()`                | ✅         |
| Heap algorithms         | ✅         |

---

## What STL Still Has That We Don’t (Intentionally)

* No iterators (STL also does **not** expose them)
* No direct `change_priority()` (STL also does **not** support this)
* No allocator support (advanced STL feature)

---
