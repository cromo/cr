---
title: "Getting func-y in Rebol and Red"
date: 2017-11-05T10:05:08-06:00
tags: [rebol, red]

draft: true
modified: false
status: in progress
belief: certain
---
One day I saw a blog post on Hacker News about a release of the Red programming language. Having never heard of it before and seeing the comments praising the effort, I decided to investigate. I thought it looked interesting, but being quite different from any language I had ever seen before - which, being a language nerd, this was interesting in its own right - and I couldn't make heads or tails out of any code. Namely, it just looked like a jumble of identifiers - I couldn't tell what was a variable, what was a function, or how many arguments functions took. It also didn't help that a trailing colon is used for assignment which was so different from anything I've seen before that it just wouldn't stick in my head.

The comments on Hacker News mentioned that Red was homoiconic like lisp - that the code is a valid data literal within the language. If you've seen lisp code - or even heard of people complain about it - you know that it has parentheses everywhere to delimit function and macro calls. This made me wonder - how does Red delimit function calls?

((maybe a treatise on how other languages call functions? C-like, haskell, lisp; maybe make its own section to introduce the problem?))

My curiosity whet, I dived into the Red documentation. Actually, it pointed me at a book for the language Red is inspired by and modeled after, Rebol 2. It took a while before even it explained how to read function calls, even though it used them through the first several chapters. Thus, this post introduces how to understand function calls in Red and Rebol.

((maybe move this up to the top?))  
After spending way too long to figure out how Red delimits function calls, ...

## Fixed arity

The answer to it all is that unlike lisp, all functions take a fixed number of arguments. When a symbol that evaluates to a function is encountered, the function is placed on a stack for evaluation until enough arguments have been provided, at which point it's popped off the stack and executed. If there are more functions on the stack waiting for values, then the return value of the function is added to the list of arguments being built up for that function, otherwise it's discarded. This allows nesting function calls and multiple statements without a delimiter.

For example, the following code shows that 2 and 3 are first multiplied together, and that result and the value 4 are then passed as arguments to `add`.

```
>> add multiply 2 3 4
== 10
```

Let's look at this execution step by step. First, it reads the word `add` and looks up its binding.

```
add multiply 2 3 4
^
```

And it sees that it's a function (technically, it's an `action!` type which is also a callable type). Semantically, it puts the function on a stack of functions waiting to execute:

Functions | Arguments
----------|----------
`add` | `_` `_`

The `add` function needs two arguments before it can run, represented here as underscores. Red then continues execution by reading the word `multiply`.

```
add multiply 2 3 4
    ^
```

It looks at its binding and finds another function. Since this function also needs two arguments, it adds it to the stack of functions waiting to execute.

Functions | Arguments
----------|----------
`add` | `_` `_`
`multiply` | `_` `_`

Then it moves on to the next value, which is the number 2.

```
add multiply 2 3 4
             ^
```

Since it is just a value, it is saved as the first argument to multiply.

Functions | Arguments
----------|----------
`add` | `_` `_`
`multiply` | `2` `_`

Then the next value is read, which is 3.

```
add multiply 2 3 4
               ^
```

This gets added to the list of arguments for the newest function added to the stack, filling out its argument list.

Functions | Arguments
----------|----------
`add` | `_` `_`
`multiply` | `2` `3`

Now that `multiply` has all the arguments it needs, it gets run and the result is used as an argument to the next function on the stack:

Functions | Arguments
----------|----------
`add` | `6` `_`

And the runtime continues on and finds the value 4, filling out `add`'s argument list and calls it, returning 10.

```
add multiply 2 3 4
                 ^
```

Functions | Arguments
----------|----------
`add` | `6` `4`

If this code was run in the REPL, then the result is printed. Otherwise it is discarded and the next "statement" begins. This strictness in the number of arguments is what allows the Rebol family to have freeform syntax.

## Refinements

Red and Rebol functions support something called refinements - these are additional flags attached to the function name that can alter the number of arguments expected by a call. Sometimes they don't add any arguments and just set a flag that alters the function's internal behavior.

To define a function that takes refinements, just specify a parameter that starts with a slash; any arguments following the refinement up to the next refinement or the end of the list are additional positional arguments that must be specified when the function is called. A function can check whether a refinement was specified by checking the word by the same name, which will be a boolean value.

```
>> f: func [a /b /c d][print [a b c d]]
== func [a /b /c d][print [a b c d]]
>> f 1 2
1 false false none
== 2
>> f/b 1 2
1 true false none
== 2
>> f/b/c 1 2
1 true true 2
>> f/c 1 2
1 false true 2
```

## Variable arguments sorta

So is there a way to simulate variable argument lists? Absolutely - if a variable number of arguments are needed, they are instead passed as Red's primary data structure - a block. `print` is an example of a function that accepts both individual values and a block of values. If given a single value, it converts it to a string and prints it. If given a block, it converts each element to a string and prints the values separated by spaces.

```
>> print 3
3
>> print "hello there"
hello there
>> print [3 true "string!"]
3 true string!
```

So there you have it - how Red and Rebol know where one function's arguments end and another's begins. It's depends on the binding of the identifiers in the code when that block is executed.

