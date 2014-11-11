clausulas(end_of_file):- !.

clausulas(S):- write(S),
               write('.'), nl,
               fail.

convert:- read(S), 
         (S \== end_of_file) -> (write(S), writeln('.'), convert);seen.



parseri:- write('Ingrese el nombre del fichero a crear'),nl,
          read(N),
          write('Ingrese las clausulas de su programa'), nl,
          tell(N),
          repeat,
	  read(S), /*Leer clausulas*/
          clausulas(S),
          !, 
          told,
          see(N). 

parsero:- convert,
	  see('ejemplo.pl'),
          listar([]).

primero([Uno|_],Uno).

segundo([_,Dos|_], Dos).

listar(L):-
      read(X),
      (X \== end_of_file)->
      listar1(X,L,Z),
      listar(Z);
      write(L),seen.

listar1(X,L,Z):-
	functor(X,Y,_),
	(Y == (:-))->
        X =..Lista,
        elimina(:-,Lista,R),
        primero(R,Uno),
        segundo(R,S),
        Dos=[S|[]],
        K=[Uno,Dos|[]],
        RR=[K|[]],
        append(L,RR,Z);
	A=[X|[[]|[]]],
	P=[A|[]],
	append(L,P,Z).


elimina(X,[X|T],T).

propiedad:-
	see('ejemplo.pl'),
	read(Lista),
	getAns(Lista,C1,F1,S1),
	append(C1,C),
	append(F1,F),
	append(S1,S),
	write('constantes'),nl,
	makeSet(C,Cs),write(Cs),nl,write('functores'),nl,makeSet(F,Fs),write(Fs),nl,write('simbolos de predicado'),nl,makeSet(S,Ss),write(Ss),nl,seen.

%elimina repetidos
makeSet([],[]).
makeSet([X|Xs], [X|Ys]) :- not(member(X,Xs)),!,makeSet(Xs,Ys).
makeSet([X|Xs], Ys) :- member(X,Xs),!,makeSet(Xs,Ys).

%de un programa expresado como lista de listas, extrae las constantes, functores y simbolos de predicados
getAns([],[],[],[]) :- !.
getAns([L|Ls], [X|Xs], [Y|Ys], [Z|Zs]) :-prop1(L,X,Y,Z),getAns(Ls,Xs,Ys,Zs).

%de una clausula, extrae las constantes, functores y simbolos de predicados.
prop1([],[],[],[]).
prop1(Rule,Cons,Func,Symb) :- getCons(Rule,Cons2), getFunc(Rule,Func2),getSymb(Rule,Symb), diff(Func2,Symb,Func), diff(Cons2,Symb,Cons).

%diferencia entre dos listas
diff([],_,[]):-!.
diff([X|Xs],Y,L) :- member(X,Y),!,diff(Xs,Y,L).
diff([X|Xs],Y,[X|L]) :- not(member(X,Y)), !,diff(Xs,Y,L).

getCons([],[]):- !.
getCons([X|Xs],[X|Ys]) :- atom(X), functor(X,_,0), !, getCons(Xs,Ys). %si es una variable atomica
getCons([X|Xs],L) :- compound(X), !,X =.. L1, L1 = [_|L2], getCons(L2,L),getCons(Xs,Ys), append(L,Ys,L).%extrae de un functor las constantes
getCons([X|Xs],Ys) :- var(X),!,getCons(Xs,Ys). %si es una variable, la ignora
%similarmente para getFunc

getFunc([],[]):- !.
getFunc([X|Xs],[Xf|L]) :- compound(X), not(var(X)),
	!, functor(X,Xf,_),X =.. L1, L1 = [_|L2],getFunc(Xs,Ys), getFunc(L2,L3),
	append(L3,Ys,L).
getFunc([X|Xs],Ys) :- (atom(X);var(X)),!, getFunc(Xs,Ys). 

getSymb([],[]).
getSymb([X|Xs],[Y|Ys]) :- functor(X,Y,_), getSymb(Xs,Ys).              
                 		     
parser:- parseri,
         parsero,
         propiedad.

