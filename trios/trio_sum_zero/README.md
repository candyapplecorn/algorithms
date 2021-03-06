# Trio Sum Zero

Write a function that takes a list and returns indices of trios of elements which sum to zero

```ruby
# input
list = [1, 2, -3, 0, 2, -2]
# output
[[1, 3, 5], [0, 2, 4], [0, 1, 2], [3, 4, 5]]

```

My first approach will be ```O(n^2) + O(n)``` time. I'll take **quadratic time** to find all sums of combinations of two. I'll then take linear time using an ~~array~~ **hash** to grab the trio pairs.

I can't remember exactly how big O works, but if I recall, there's the idea of dominating factors. The quadratic portion should dominate the linear portion, so I believe rather than calling this ```O(n^2 + n)```, it'd be more correct to just call it ```O(n^2)```, aka quadratic

## EDIT

My first approach ended up taking ```O(n^2) + O(8n)``` time. It could definitely be improved, many of those eight linear operations are probably unnecessary
