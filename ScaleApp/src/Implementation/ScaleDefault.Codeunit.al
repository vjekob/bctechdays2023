codeunit 60101 "Scale Default" implements IScale
{

    procedure GetWeight() Result: Decimal;
    begin
        error('No scale was set up, so not able to get weight');
    end;

    procedure Tare();
    begin
        error('No scale was set up, so not able to tare');
    end;
}