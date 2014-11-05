clausulas(end_of_file):- !.

clausulas(S):- write(S),
               write('.'), nl,
               fail.

convert(IN,OUT):- read(S), 
                 (S == end_of_file -> OUT = IN;
                  convert([S|IN],OUT)).

convertList([],[]).
convertList([S|C], [[S1|[E]]|NList]):-
           (( arg(1, S, S1),                                                                        
              arg(2, S, C1),
           ((functor(C1, ',', _),
             convEcu(C1, E));                       
             E = [C1]) );                                            
            (S1 = S, E = [] )),                                                     
%           write_term(S1, [partial(true)]), nl,                                                                   
%           write_term(E, [partial(true)]), nl,                                                            
           convertList(C, NList).

convEcu(B, E) :- %write(B),nl,
        (functor(B, ',' ,_),                                  
         arg(1, B, E),                                          
         arg(2, B, Args),
         convEcu(Args, Args2),
         append(Args2, [E], E));
        E = [B].
 %       write_term(E, [partial(true)]), nl,
 %       write_term(B, [partial(true)]), nl.


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

parsero:- convert([],R),
          reverse(R,LIST),
	 % write(LIST),
          seen, 
          convertList(LIST,NList),
          write(NList).      
                 		     
parser:- parseri, parsero.

