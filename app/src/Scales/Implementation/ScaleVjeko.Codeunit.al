codeunit 50005 "Scale Vjeko" implements IScale
{

    procedure GetWeight() Result: Decimal;
    begin
        message('Info: Vjeko-implementation');
        Result := 100 + Random(30);
    end;

    procedure Tare();
    begin
        //TODO: Implement Vjeko Tare
    end;

    procedure Getinfo() Result: Text;
    begin
        exit('Info: Scale "Vjeko"');
    end;

}