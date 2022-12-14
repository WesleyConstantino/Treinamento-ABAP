*********        Include PAI

*&---------------------------------------------------------------------*
*&  Include           MZTRMPWES001I01
*&---------------------------------------------------------------------*

*USER COMMANDS:

*&---------------------------------------------------------------------*
*       Tela 9000
*----------------------------------------------------------------------*
*AÇÃO DOS BOTÕES DA TELA 9000
MODULE user_command_9000 INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "ABANDONA PROGRAMA
    WHEN 'CAD_CLIENTES'.
      PERFORM zf_gera_cod_autmatico.  "Reflete na tela referenciada; nesse caso a 9001
      CALL SCREEN 9001."Para chamar a tela.
    WHEN 'BACK' OR 'CANCEL'.
      CLEAR wa_clientes.
      LEAVE TO SCREEN 0.  "Para chamar a telaLEAVE TO SCREEN 0.
    WHEN 'CONSULTAR'.
      CALL SCREEN 9002.
    WHEN 'EXIBE_ALUGUEL'.
      CALL SCREEN 9004.
    WHEN 'CAD_ALUGUEL'.
      PERFORM zf_gera_cod_autmatico_9003.
      CALL SCREEN 9003.
    WHEN 'CAD_AUTOMOVEL'.
      CALL TRANSACTION 'ZTRWES002'.
    WHEN 'CAD_MARCA'.
      CALL TRANSACTION 'ZTRWES001'.
    WHEN 'BT_RELATORIOS'.
      CALL TRANSACTION 'ZTRWES006'.
      WHEN 'COD_ALU_CLI'.
      CALL TRANSACTION 'ZTRTWESLEY'.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*       Tela 9001
*----------------------------------------------------------------------*
*AÇÃO DOS BOTÕES 9001
MODULE user_command_9001 INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "ABANDONA PROGRAMA
    WHEN 'BACK' OR 'CANCEL'.
      CLEAR wa_clientes.
      LEAVE TO SCREEN 0.
    WHEN 'GRAVAR'.
      PERFORM zf_grava.
    WHEN 'BT_LIMPAR'.
      PERFORM zf_popup.
      PERFORM zf_oculta_bt_alt.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*       Tela 9002
*----------------------------------------------------------------------*
*AÇÃO DOS BOTÕES 9002
MODULE user_command_9002 INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "ABANDONA PROGRAMA
    WHEN 'BACK' OR 'CANCEL'.
      CLEAR wa_clientes.
      LEAVE TO SCREEN 0. "Para chamar a telaLEAVE TO SCREEN 0.
    WHEN 'CONSULTAR'.
      IF wa_clientes-cpfcli IS INITIAL AND
         wa_clientes-rgcli IS INITIAL AND
         wa_clientes-codcli IS INITIAL.
        MESSAGE s398(00) WITH text-m03 DISPLAY LIKE 'E'.
      ELSE.
        PERFORM zf_select_9002.
      ENDIF.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*       Tela 9003
*----------------------------------------------------------------------*
*AÇÃO DOS BOTÕES 9003
MODULE user_command_9003 INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "ABANDONA PROGRAMA
    WHEN 'BACK' OR 'CANCEL'.
      CLEAR: wa_clientes,
             wa_cad_automoveis,
             wa_aluguel_automovel.
      LEAVE TO SCREEN 0.
    WHEN 'GRAVAR'.
      PERFORM zf_grava_aluguel.
    WHEN 'LIMPAR'.
      CLEAR: wa_clientes,
             wa_cad_automoveis,
             wa_aluguel_automovel-datafim,
             wa_aluguel_automovel-datainicio,
             wa_aluguel_automovel-horainicio,
             wa_aluguel_automovel-horafim,
             wa_aluguel_automovel-valor.
    WHEN 'ENTER'.
      PERFORM zf_calcula_valor_9003.
      PERFORM zf_selciona_cli_9003.
  ENDCASE.
*Ação do radio button
  CASE rb_com_desconto.
    WHEN 'X'.
      IF wa_aluguel_automovel-valor IS NOT INITIAL.
        PERFORM zf_calcula_desconto_9003.
      ENDIF.
    WHEN ' '.
      IF wa_aluguel_automovel-valor IS NOT INITIAL.
        PERFORM zf_calcula_valor_9003.
      ENDIF.
  ENDCASE.

ENDMODULE.

*&---------------------------------------------------------------------*
*       Tela 9004
*----------------------------------------------------------------------*
*AÇÃO DOS BOTÕES 9004
MODULE user_command_9004 INPUT.

  CASE ok_code.
    WHEN 'EXIT'.
      LEAVE PROGRAM. "ABANDONA PROGRAMA
    WHEN 'BACK' OR 'CANCEL'.
      CLEAR: wa_clientes,
             wa_cad_automoveis,
             wa_aluguel_automovel.
      LEAVE TO SCREEN 0.
    WHEN 'BT_CONSULTAR'.
      IF  wa_aluguel_automovel-codalu IS INITIAL.
        MESSAGE s398(00) WITH text-m03 DISPLAY LIKE 'E'.
      ELSE.
        PERFORM zf_select_9004.
      ENDIF.
  ENDCASE.

ENDMODULE.
