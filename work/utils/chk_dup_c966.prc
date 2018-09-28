/* Last update: 20-Maio-2018 18:51 */
/* Remove cotas duplicadas */
/* Para ignorar as alterações à cota apagar as linhas seguintes */

lw(10000)
'D966D9000D9777D9866D9888'/

/* Fase 1 - reune todas as siglas  */
putenv(v9888^l'='v9888^n)
/* Fase 2 - Cria o campo 9866 com uma cota de cada biblioteca - controlo pela SIGLA  */
(
  putenv(s(V966^l)'=^n'f(val(getenv(s(V966^l)))+1,0,0)'^l'V966^l)
  proc('A9888~'v9888|%|,getenv(V966^l)'~')
  proc('A9666~'v9666|%|,if v966^l<>'' then s('^y',v966^y,'^l',v966^l) fi'~')
  if instr(V9000[1],s(|/|v966^l|/|))<=0  then 
     proc('D9777A9777~^n1^l',V966^l,'~')
     proc('A9866~',V966,'~')
     proc('D9000A9000~',V9000[1],|/|V966^l|/|,'~')
  fi/
 )

/* Fase 3 - Cria variavel de ambiente para cada SIGLA aproveitando apenas a última ocorrência */
(
  putenv(v9888^l'='v9888^n)
  v000
)

/* Fase 4 - Cria variavel de ambiente para cada SIGLA aproveitando apenas a última ocorrência */

(if v9866<>'' then
    'A966~'
       '  ',|^a|V9866^a,|^l|V9866^l,|^s|V9866^s,|^m|V9866^m,s('^c',if val(v9888[last]^n)>1 then getenv(V9866^l) else v9866^c fi)
     '~'
fi)

/* Fase 5 - Limpa as variáveis de ambiente */
(
  putenv(v9888^l'=')
  v000
)

