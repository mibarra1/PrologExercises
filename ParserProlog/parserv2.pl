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
              
                 		     
parser:- parseri, parsero.

