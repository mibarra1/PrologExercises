clausulas(end_of_file):- !.

clausulas(S):- write(S),
               write('.'), nl,
               fail.

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

parsero:- write('Su archivo es:'),
	  repeat,
          read(S),
          clausulas(S),
          !,
          seen.      

parser:- parseri, parsero.

