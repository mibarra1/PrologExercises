clausulas(end_of_file):- !.

clausulas(S):- write(S),
               write('.'), nl,
               fail.

convert(IN,OUT):- read(S), 
                 (S == end_of_file -> OUT = IN;
                  convert([[S]|IN],OUT) ).

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
	  write(LIST),
          seen.      

parser:- parseri, parsero.

