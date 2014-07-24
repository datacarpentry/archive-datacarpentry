---
layout: lesson
root: ../..
title: Introducing the Shell
---
<div class="objectives" markdown="1">

#### Objectives
*   Explain how the shell relates to the keyboard, the screen, the operating system, and users' programs.
*   Explain when and why command-line interfaces should be used instead of graphical interfaces.

</div>

#### What and Why

At a high level, computers do four things:

-   run programs;
-   store data;
-   communicate with each other; and
-   interact with us.

They can do the last of these in many different ways,
including direct brain-computer links and speech interfaces.
Since these are still in their infancy,
most of us use windows, icons, mice, and pointers.
These technologies didn't become widespread until the 1980s,
but their roots go back to Doug Engelbart's work in the 1960s,
which you can see in what has been called
"[The Mother of All Demos](http://www.youtube.com/watch?v=a11JDLBXtPQ)".

Going back even further,
the only way to interact with early computers was to rewire them.
But in between,
from the 1950s to the 1980s,
most people used line printers.
These devices only allowed input and output of the letters, numbers, and punctuation found on a standard keyboard,
so programming languages and interfaces had to be designed around that constraint.

This kind of interface is called a
[command-line interface](../../gloss.html#cli), or CLI,
to distinguish it from the
[graphical user interface](../../gloss.html#gui), or GUI,
that most people now use.
The heart of a CLI is a [read-evaluate-print loop](../../gloss.html#repl), or REPL:
when the user types a command and then presses the enter (or return) key,
the computer reads it,
executes it,
and prints its output.
The user then types another command,
and so on until the user logs off.

This description makes it sound as though the user sends commands directly to the computer,
and the computer sends output directly to the user.
In fact,
there is usually a program in between called a
[command shell](../../gloss.html#shell).
What the user types goes into the shell;
it figures out what commands to run and orders the computer to execute them.

A shell is a program like any other.
What's special about it is that its job is to run other programs
rather than to do calculations itself.
The most popular Unix shell is Bash,
the Bourne Again SHell
(so-called because it's derived from a shell written by Stephen Bourne&mdash;this
is what passes for wit among programmers).
Bash is the default shell on most modern implementations of Unix,
and in most packages that provide Unix-like tools for Windows.

Using Bash or any other shell
sometimes feels more like programming than like using a mouse.
Commands are terse (often only a couple of characters long),
their names are frequently cryptic,
and their output is lines of text rather than something visual like a graph.
On the other hand,
the shell allows us to combine existing tools in powerful ways with only a few keystrokes
and to set up pipelines to handle large volumes of data automatically.
In addition,
the command line is often the easiest way to interact with remote machines.
As clusters and cloud computing become more popular for scientific data crunching,
being able to drive them is becoming a necessary skill.

<div class="keypoints" markdown="1">

#### Key Points
*   A shell is a program whose primary purpose is to read commands and run other programs.
*   The shell's main advantages are its high action-to-keystroke ratio,
    its support for automating repetitive tasks,
    and that it can be used to access networked machines.
*   The shell's main disadvantages are its primarily textual nature
    and how cryptic its commands and operation can be.

</div>
