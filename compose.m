% COMPOSE Compose an array of codes into a character
%
% Usage
%    code_char = compose(code);
%
% Input
%    code: An array of size 4-by-n where each of the four elements in each
%       column corresponding to a different direction (up, right, down, and
%       left) which can take one of the values 1 (empty), 2 (thin) or 3
%       (thick).
%
% Output
%     code_char: An array of size 1-by-n containing the Unicode code point
%        values that correspond to the inputs. For example [1 2 1 2] gives a
%        horizontal line while [3 2 3 2] gives a thin horizontal line crossed
%        by a thick vertical one.

function code_char = compose(code)
    chars = cell(3,3,3,3);

    chars(1,1,1,2) = '74';
    chars(2,1,1,1) = '75';
    chars(1,2,1,1) = '76';
    chars(1,1,2,1) = '77';
    chars(1,1,1,3) = '78';
    chars(3,1,1,1) = '79';
    chars(1,3,1,1) = '7a';
    chars(1,1,3,1) = '7b';

    chars(1,2,1,2) = '00';
    chars(1,3,1,3) = '01';
    chars(2,1,2,1) = '02';
    chars(3,1,3,1) = '03';
    chars(1,3,1,2) = '7c';
    chars(2,1,3,1) = '7d';
    chars(1,2,1,3) = '7e';
    chars(3,1,2,1) = '7f';
    chars(1,2,2,1) = '0c';
    chars(1,3,2,1) = '0d';
    chars(1,2,3,1) = '0e';
    chars(1,3,3,1) = '0f';
    chars(1,1,2,2) = '10';
    chars(1,1,2,3) = '11';
    chars(1,1,3,2) = '12';
    chars(1,1,3,3) = '13';
    chars(2,2,1,1) = '14';
    chars(2,3,1,1) = '15';
    chars(3,2,1,1) = '16';
    chars(3,3,1,1) = '17';
    chars(2,1,1,2) = '18';
    chars(2,1,1,3) = '19';
    chars(3,1,1,2) = '1a';
    chars(3,1,1,3) = '1b';

    chars(2,2,2,1) = '1c';
    chars(2,3,2,1) = '1d';
    chars(3,2,2,1) = '1e';
    chars(2,2,3,1) = '1f';
    chars(3,2,3,1) = '20';
    chars(3,3,2,1) = '21';
    chars(2,3,3,1) = '22';
    chars(3,3,3,1) = '23';
    chars(2,1,2,2) = '24';
    chars(2,1,2,3) = '25';
    chars(3,1,2,2) = '26';
    chars(2,1,3,2) = '27';
    chars(3,1,3,2) = '28';
    chars(3,1,2,3) = '29';
    chars(2,1,3,3) = '2a';
    chars(3,1,3,3) = '2b';
    chars(1,2,2,2) = '2c';
    chars(1,2,2,3) = '2d';
    chars(1,3,2,2) = '2e';
    chars(1,3,2,3) = '2f';
    chars(1,2,3,2) = '30';
    chars(1,2,3,3) = '31';
    chars(1,3,3,2) = '32';
    chars(1,3,3,3) = '33';
    chars(2,2,1,2) = '34';
    chars(2,2,1,3) = '35';
    chars(2,3,1,2) = '36';
    chars(2,3,1,3) = '37';
    chars(3,2,1,2) = '38';
    chars(3,2,1,3) = '39';
    chars(3,3,1,2) = '3a';
    chars(3,3,1,3) = '3b';

    chars(2,2,2,2) = '3c';
    chars(2,2,2,3) = '3d';
    chars(2,3,2,2) = '3e';
    chars(2,3,2,3) = '3f';
    chars(3,2,2,2) = '40';
    chars(2,2,3,2) = '41';
    chars(3,2,3,2) = '42';
    chars(3,2,2,3) = '43';
    chars(3,3,2,2) = '44';
    chars(2,2,3,3) = '45';
    chars(2,3,3,2) = '46';
    chars(3,3,2,3) = '47';
    chars(2,3,3,3) = '48';
    chars(3,2,3,3) = '49';
    chars(3,3,3,2) = '4a';
    chars(3,3,3,3) = '4b';

    chars(1,1,1,1) = '73';

    chars = hex2dec('2500') + cellfun(@hex2dec, chars);

    chars(1,1,1,1) = 32;

    code_char = chars(1+3.^[0:3]*(code-1));
end
