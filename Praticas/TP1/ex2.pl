pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb,breitling).
team(besenyei,redbull).
team(chambliss,redbull).
team(maclean,mrt).
team(mangold,cobra).
team(jones,matador).
team(bonhomme,matador).

plane(lamb,mx2).
plane(besenyei,edge540).
plane(chambliss,edge540).
plane(maclean,edge540).
plane(mangold,edge540).
plane(jones,edge540).
plane(bonhomme,edge540).

circuit(porto).
circuit(istanbul).
circuit(budapest).

winner(porto,jones).
winner(budapest,mangold).
winner(istanbul,mangold).

gates(istanbul,9).
gates(budapest,6).
gates(porto,5).

winner_team(C,T):-team(P,T),winner(C,P).