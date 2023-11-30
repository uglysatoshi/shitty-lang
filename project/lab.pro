DOMAINS 
  conditions = number*
  number = integer
  category = string
  
global facts - pravila
  topic(category)
  rule(number, category, category, conditions)
  cond(number, category)
  yes(number)
  no(number)
  
PREDICATES
  do_expert_job
  nondeterm show_menu
  nondeterm do_consulting
  nondeterm process(integer)
  info(category)
  goes(category)
  listopt
  clear
  eval_reply(char)
  nondeterm go(category)
  nondeterm check(number, conditions)
  inpo(number, number, string)
  do_answer(number, string, number, number)
  nondeterm append_new_topic
  nondeterm append_new_rule
  
CLAUSES 
  do_expert_job:-
    show_menu, nl,
    write("Press any key"), 
    readchar(_), exit.
  
  show_menu:-
    write("->  1 - consultation"), nl,
    write("->  2 - add new topic"), nl,
    write("->  3 - add new rule"), nl,
    write("->  0 - exit"), nl,
    readint(Choice), process(Choice).
    
  process(1):-
    do_consulting.
  process(2):-
    append_new_topic.
  process(3):-
    append_new_rule.
  process(0):-
    exit.
    
  do_consulting:-
    goes(Mygoal), 
    go(Mygoal), !.
  do_consulting:-
    nl, write("I cant help you").
  do_consulting.
  
  goes(MyGoal):-
    clear, nl,  
    write("To start enter 'washer'"), nl,
    write("If you want to see the washers types, enter '?'"), nl,
    readln(Mygoal), info(Mygoal), !.
    
  info("?"):-
    !, listopt, nl,
    exit.
  info("washer").
  
  listopt:-
    write("Washers types are: "), nl,
    topic(Washer),
    write("->",Washer), nl, fail.
  listopt.
  
  inpo(Rno, Bno, Text):-
    write("Question:- ", Text, "?"),nl,
    write("\tType 1 for 'yes': "), nl,
    write("\tType 2 for 'no': "), nl,
    readint(Response),
    do_answer(Rno, Text, Bno, Response).
    
  eval_reply('y'):-
    write("I hope you have found this helpful !").
  eval_reply('n'):-
    write("I am sorry I can't help you !").
    
  go(Mygoal):-
    NOT(rule(_, Mygoal, _, _)), !, nl,
    write("the washer you have indicated is a(n)", Mygoal, "."), nl,
    write("Is a washer you would like to have (y/n)?"), nl,
    readchar(R),
    eval_reply(R).
  go(Mygoal):-
    rule(Rno, Mygoal, Ny, Cond),
    check(Rno, Cond),
    go(Ny).
  
  check(Rno, [Bno|Rest]):-
    yes(Bno), !,
    check(Rno, Rest).
  check(_, [Bno|_]):-
    no(Bno), !, fail.
  check(Rno, [Bno|Rest]):-
    cond(Bno, Text), 
    inpo(Rno, Bno, Text),
    check(Rno, Rest).
  check(_, []).
  
  do_answer(_, _, _, 0):-
    exit.
  do_answer(_, _, Bno, 1):-
    assert(yes(Bno)),
    write("yes"), nl.
  do_answer(_, _, Bno, 2):-
    assert(no(Bno)),
    write("yes"), nl, fail.
  
  clear:-
    retract(yes(_)), fail;
    retract(no(_)), fail;
    !.
  append_new_topic:-
    write("Enter a body of topic: "),
    readln(Topic), assertz(topic(Topic)),
    save("base.dba", pravila),
    show_menu.
    
  append_new_rule:-
    write("Enter a new rule: "), nl,
    write("Enter a number of a rule(>30): "), readint(Number),
    write("Enter a type of washer(topic): "), readln(WasherType),
    write("Enter a name of washer: "), readln(WasherName),
    write("Enter a three property's of washer(integer numbers from 1 to 15): "),
    readint(FirstProperty), readint(SecondProperty), readint(ThirdProperty),
    assertz(rule(Number, WasherType, WasherName, [FirstProperty, SecondProperty, ThirdProperty])),
    save("base.dba", pravila),
    show_menu.
    
GOAL
  consult("base.dba", pravila),
  show_menu.