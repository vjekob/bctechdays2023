codeunit 50004 "Scale Unknown" implements IScale
{

    procedure GetWeight() Result: Decimal;
    begin
        error('The scale that was previously set up, is not available anymore.');
    end;

    procedure Tare();
    begin
        error('The scale that was previously set up, is not available anymore.');
    end;
}