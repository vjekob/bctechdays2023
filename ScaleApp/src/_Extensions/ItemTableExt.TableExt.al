tableextension 60100 "ItemTableExt" extends Item
{
    fields
    {
        field(50000; "Weight"; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
        }
    }

    procedure GetWeight()
    var
        GetWeightNewMeth: Codeunit "GetWeight New Meth";
    begin
        GetWeightNewMeth.GetWeight(Rec);
    end;

}