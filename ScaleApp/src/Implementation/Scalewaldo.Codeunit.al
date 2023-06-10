codeunit 60104 "Scale waldo" implements IScale
{

    procedure GetWeight() Result: Decimal;
    begin
        message('Info: waldo-implementation');
        Result := 100 - Random(30);
    end;

    procedure Tare();
    begin
        //TODO: Implement waldo Tare
    end;

    procedure Getinfo() Result: Text;
    begin
        exit('Info: Scale "waldo"');
    end;

}