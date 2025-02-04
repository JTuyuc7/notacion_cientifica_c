import java.util.ArrayList;
import java.util.List;

%%
%public
%class NotationFlexer
%unicode
%function yylex
%type String

%{
/**
 * Lista de fechas válidas que se van reconociendo.
 * Ejemplo de cómo podrías almacenar tokens válidos.
 */
private List<String> validNotation = new ArrayList<>();

public List<String> getFechasValidas() {
    return validNotation;
}

%}

/* Macros para notación científica */
DIGITO       = [0-9]
SIGNO        = [+\-]
NUM          = {DIGITO}+
SCI_NOTATION = {SIGNO}?{NUM}(\.{NUM})?[Ee]{SIGNO}?{NUM}

/* Ignorar espacios, tabulaciones, saltos de línea... */
WHITESPACE   = [ \t\n\r]+

%%


/* NÚMEROS EN NOTACIÓN CIENTÍFICA, p.ej -1.23E+10, 3E9, etc. */
{SCI_NOTATION} {
    String texto = yytext();
    // Agrear a la lista
    validNotation.add(texto);
    /* Aquí únicamente devolvemos el token; o podrías guardarlo en una lista */
    return texto;
}

/* Ignora cualquier otro carácter suelto (incluyendo "\n" si no se capturó arriba). */
[^\\] {
    /* No hacemos nada. Podrías retornar un error o simplemente ignorar */
}

/* Al llegar al EOF, regresamos null para indicar fin de la entrada */
<<EOF>> {
    return null;
}
