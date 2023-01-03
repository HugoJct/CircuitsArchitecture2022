# Partie logisim :

## **Flags NZP** :

---

### Calcul de l'état :

Si WriteReg = 1, alors on met à jour les flags NZP, sinon ceux-ci gardent leur valeur précédente. Cela est fait grâce à un multiplexeur permettant de sélectionner l'entrée désirée.

Le résultat du calcul est négatif si le bit de poids fort est à 1 (complément à deux), il est nul si tous ses bits sont à zéro et positif si aucune des deux conditions précédentes n'est remplie.

---

### Évaluation de la condition de saut :

La condition de saut est évaluée vraie si l'instruction courante est un branchement et si l'état des flags NZP spécifié dans l'instruction est effectivement leur état dans le circuit.

---

## **Decodage Instruction** : 

---

Les instructions étant catégorisées par type dans leur tableau de Karnaugh, il suffit de regarder les deux premiers bits de leur code d'opération pour pouvoir les différencier.  
Seuls les chargements et les opérations arithmétiques peuvent modifier les registres.

---

## **ALU** :

---

L'instruction SCAN est branchée sur l'emplacement laissé vide du LC-3.

---

## **WriteVal** :

---

écrit val

---

## **Registre PC** : 

--- 

La valeur de PC est modifiée si l'instruction courante est un saut et que les conditions sur NZP sont satisfaites.  

PC prend la valeur de BaseR si l'instruction courante est JMP ou JSRR et est incrémenté de l'offset spécifié sinon. Cet offset est codé sur 9 bits dans le cas de BR et sur 11 bits dans le cas de JSR.

---

## **Write R7** :

---

Ce circuit permet de décider si PC doit doit être sauvegardé ou non.  
Le registre PC doit être sauvegardé dans R7 lors d'appels à JSR ou JSRR afin de permettre un retour à l'appelant.

Lorsque le pin WriteR7 de ce circuit est à 0, ce circuit est transparent.  
Lorsque ce pin est à 1 en revanche: 
- la valeur de PC incrémentée de 1 est envoyée vers les registres
- le pin d'écriture des registres est positionné à 1
- l'adresse du registre à écrire est forcée à 7

Ces actions ne sont effectuées que lors de la phase d'exécution de l'instruction (pin Exec à 1).

---