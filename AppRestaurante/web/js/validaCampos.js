
function validarCNPJ(fieldCNPJ) {

    var cnpj = fieldCNPJ;

    cnpj = cnpj.replace('/', '-');
    cnpj = cnpj.replace(/[.-]/g, '');

    if (cnpj.length !== 14 || cnpj === "00000000000000") {
        return false;
    }

    var dig1 = 0;
    var dig2 = 0;
    var x;
    var Mult1 = '543298765432';
    var Mult2 = '6543298765432';

    for (x = 0; x <= 11; x++)
        dig1 = dig1 + (parseInt(cnpj.slice(x, x + 1), 10) * parseInt(Mult1.slice(x, x + 1), 10));
    for (x = 0; x <= 12; x++)
        dig2 = dig2 + (parseInt(cnpj.slice(x, x + 1), 10) * parseInt(Mult2.slice(x, x + 1), 10));

    dig1 = (dig1 * 10) % 11;
    dig2 = (dig2 * 10) % 11;

    if (dig1 === 10)
        dig1 = 0;
    if (dig2 === 10)
        dig2 = 0;

    if (dig1 !== parseInt(cnpj.slice(12, 13), 10)) {
        return false;
    }

    if (dig2 !== parseInt(cnpj.slice(13, 14), 10)) {
        return false;
    }

    return true;

}
