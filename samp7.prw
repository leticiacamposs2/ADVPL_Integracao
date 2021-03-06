#include "protheus.ch"

user function samp7()
	Local cTab := "ZJ0"
	Private cCadastro := "Pessoas"

	DbSelectArea(cTab)
	(cTab)->(DbSetOrder(1))

	MBrowse(,,,,cTab)
return


Static Function Menudef()
	Local aMenu := {}
	Local aOptAnimais := {}
	Local aImpExt := {}

	AADD(aMenu, {"Pesquisar"	,"AxPesqui"	 , 0, 1 } )
	AADD(aMenu, {"Visualizar"	,"AxVisual"	 , 0, 2 } )
	AADD(aMenu, {"Incluir"		,"AxInclui"  , 0, 3 } )
	AADD(aMenu, {"Alterar"		,"AxAltera"	 , 0, 4 } )
	AADD(aMenu, {"Excluir"		,"u_s7Exc"	 , 0, 5 } )
	
	AADD(aOptAnimais, {"Ver Animais"	, "u_s7Ver"	 , 0, 2 } )
	AADD(aOptAnimais, {"Alterar V�nculos", "u_s7Alt"	 , 0, 4 } )
	AADD(aMenu, {"Animais"	,aOptAnimais	 , 0, 1 } )

	AADD(aImpExt, {"Imp. Txt", "u_sampImp1"	 , 0, 3 } )
	AADD(aImpExt, {"Exp. Txt", "u_sampExp1"	 , 0, 2 } )
	AADD(aMenu, {"Imp/Exp TXT",aImpExt	 , 0, 1 } )
	
Return aMenu


User Function s7Ver(cAlias, nRecno, nOpc)
	Local aHeaderZJ2 := {}
	Local aColsZJ2 := {}
	Local cSeek := ""
	Local cWhile := ""
	Local oGetDados := Nil
	Local oDlg := Nil
	Local oEnchoice := Nil
	
	DbSelectArea("ZJ2")

	cSeek  := xFilial("ZJ2")+ZJ0->ZJ0_ID 
 	cWhile := "ZJ2->ZJ2_FILIAL + ZJ2->ZJ2_IDPESS"

	FillGetDados( 2, "ZJ2", 1, cSeek,; 
				{||&(cWhile)}, /*{|| bCond,bAct1,bAct2}*/, /*aNoFields*/,; 
				/*aYesFields*/, /*lOnlyYes*/, /*cQuery*/, /*bMontAcols*/, .F. /*lEmptyInc*/,; 
				aHeaderZJ2 /*aHeaderAux*/, aColsZJ2 /*aColsAux*/,/*bafterCols*/ , /*bBeforeCols*/,;
				/*bAfterHeader*/, /*cAliasQry*/)
	
	Define MSDialog oDlg Title "Ver Animais" From 0,0 To 400,600 Pixel

	RegToMemory("ZJ0",.F.)
	oEnchoice := MsMGet():New("ZJ0" /*cAlias*/, , 2 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 0/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	oGetDados := MsNewGetDados():New( 100/*nTop*/, 0/*nLeft*/,200/*nBottom*/,300/*nRight*/,;
								/*GD_INSERT + GD_UPDATE + GD_DELETE*/ /*nStyle*/, /*uLinhaOk*/,/*uTudoOk*/,/*cIniCpos*/,;
								/*aAlter*/,/*nFreeze*/,/*nMax*/,/*cFieldOk*/,;
								/*uSuperDel*/,/*uDelOk*/, oDlg /*oWnd*/, aHeaderZJ2 /*aHeader*/,;
								aColsZJ2 /*aCols*/, /*uChange*/, /*cTela*/ )

	Activate MSDialog oDlg Centered
Return


User Function s7Alt(cAlias, nRecno, nOpc)
	Local aHeaderZJ2 := {}
	Local aColsZJ2 := {}
	Local cSeek := ""
	Local cWhile := ""
	Local oGetDados := Nil
	Local oDlg := Nil
	Local oEnchoice := Nil
	Local nOpca := 0
	
	DbSelectArea("ZJ2")

	cSeek  := xFilial("ZJ2")+ZJ0->ZJ0_ID 
 	cWhile := "ZJ2->ZJ2_FILIAL + ZJ2->ZJ2_IDPESS"

	FillGetDados( 4, "ZJ2", 1, cSeek,; 
				{||&(cWhile)}, /*{|| bCond,bAct1,bAct2}*/, {"ZJ2_IDPESS"}/*aNoFields*/,; 
				/*aYesFields*/, /*lOnlyYes*/, /*cQuery*/, /*bMontAcols*/, .F. /*lEmptyInc*/,; 
				aHeaderZJ2 /*aHeaderAux*/, aColsZJ2 /*aColsAux*/,/*bafterCols*/ , /*bBeforeCols*/,;
				/*bAfterHeader*/, /*cAliasQry*/)
	
	Define MSDialog oDlg Title "Alterar V�nculos" From 0,0 To 400,600 Pixel
	
	RegToMemory("ZJ0",.F.)
	oEnchoice := MsMGet():New("ZJ0" /*cAlias*/, , 2 /*nOpc*/,;
						, , , /*aAcho*/,;
						{ 30/*nTop*/, 0/*nLeft*/, 100/*nBottom*/, 300/*nRight*/ }/*aPos*/, /*aCpos*/, /*nModelo*/, , , ,;
						oDlg /*oWnd*/, /*lF3*/, /*lMemoria*/, /*lColumn*/,;
						/*caTela*/, /*lNoFolder*/, /*lProperty*/,;
						/*aField*/, /*aFolder*/, /*lCreate*/, /*lNoMDIStretch*/, )

	// Cria o grid para altera��o
	oGetDados := MsNewGetDados():New( 100/*nTop*/, 0/*nLeft*/, 200/*nBottom*/, 300/*nRight*/,;
								GD_INSERT + GD_UPDATE + GD_DELETE /*nStyle*/, /*uLinhaOk*/, /*uTudoOk*/, /*cIniCpos*/,;
								/*aAlter*/, /*nFreeze*/, /*nMax*/, /*cFieldOk*/,;
								/*uSuperDel*/, /*uDelOk*/, oDlg /*oWnd*/, aHeaderZJ2 /*aHeader*/,;
								aColsZJ2 /*aCols*/, /*uChange*/, /*cTela*/ )

	Activate MSDialog oDlg CENTERED ;
		ON INIT EnchoiceBar(oDlg, ;
			{|| If( Obrigatorio( oEnchoice:aGets, oEnchoice:aTela ) .And. oGetDados:TudoOk(), (nOpca := 1, oDlg:End() ), ) },; // bOK
			 {|| oDlg:End() } ) //bCancel

	If nOpca == 1
		// Gravar os dados do aCols na tabela ZJ2
		Gravar( aHeaderZJ2, oGetDados:aCols )
	EndIf

Return


Static Function Gravar( aHeader, aCols )
	Local nLinha := 0
	Local nPosRecWt := 0
	Local nPosIdAnim := 0
	Local nLastPos := 0

	// Descobrir posi��o do campo RecnoWT no aHeader
	nPosRecWt := aScan( aHeader, {|x|x[2]=="ZJ2_REC_WT" } )
	nPosIdAnim := aScan( aHeader, {|x|x[2]=="ZJ2_IDANIM" } )
	nLastPos := Len(aHeader)+1
	
	For nLinha := 1 To Len(aCols)
		// Avaliar se o RecnoWT � Zero no aCols
		If aCols[nLinha,nPosRecWt] == 0
			// Se for 0 devo incluir um registro
			// Reclock com .T.
			GravarZJ2( 3,;
					   M->ZJ0_ID /*como pegar o id pessoa / M->ZJ0_ID funciona? */,;
					   aCols[nLinha,nPosIdAnim] /*como pegar o id animal / e aqui precisa do qu�? */ )
		Else
		// Caso n�o seja inclus�o
			// Posicionar no Recno lido do campo RecnoWT
			ZJ2->( DbGoTo( aCols[nLinha,nPosRecWt] ) )
			// A linha foi exclu�da no aCols?

			If aCols[nLinha,nLastPos]
			//   verificar o �ltimo campo do aCols (.T. foi exclu�da)
				// usar o DbDelete
				GravarZJ2( 5 ) // N�o precisa passar os outros par�metros!
			Else
				// Se n�o foi  exclu�da a linha e precisa alterar o conte�do
				If !( ZJ2->ZJ2_IDANIM == aCols[nLinha,nPosIdAnim])
					// Alterar o conte�do dos campos na linha posicionada
					GravarZJ2( 4,; // precisa dos demais par�metros?
							   M->ZJ0_ID ,; //como pegar o id pessoa / M->ZJ0_ID funciona? */
							   aCols[nLinha,nPosIdAnim] ) //como pegar o id animal / e aqui precisa do qu�?
				EndIf
			EndIf

		EndIf
	Next nLinha

Return


Static Function GravarZJ2( nOpc, cIdPessoa, cIdAnimal )
	If nOpc == 5
		Reclock("ZJ2",.F.)
			ZJ2->(DbDelete())
		ZJ2->(MsUnlock())
	Else
		Reclock("ZJ2",(nOpc==3))
			ZJ2->ZJ2_FILIAL := xFilial("ZJ2")
			ZJ2->ZJ2_IDPESS := cIdPessoa
			ZJ2->ZJ2_IDANIM := cIdAnimal
		ZJ2->(MsUnlock())
	EndIf
Return


User Function s7Exc( cAlias, nRecno, nOpcMenu )
	Local aParams := Array(4)
	aParams[1] := {|| .T.}
	aParams[2] := {|| VldExc() }
	aParams[3] := {|| .T.}
	aParams[4] := {|| .T.}

	AxDeleta( cAlias, nRecno, nOpcMenu, , , , aParams, , )
Return


Static Function VldExc()
	Local lRet := .T.
	Local cIdPessoa := ZJ0->ZJ0_ID

	DbSelectArea("ZJ2")
	ZJ2->(DbSetOrder(1)) // ZJ2_FILIAL + ZJ2_IDPESS + ZJ2_IDANIM

	If ZJ2->( DbSeek( xFilial("ZJ2")+cIdPessoa ) )
		lRet := .F.
		Help(' ',1,'NODELPESSOA',,"A pessoa est� vinculada a algum animal",1,0,,,,,,{"Remova o relacionamento antes de prosseguir"})
	EndIf
Return lRet
