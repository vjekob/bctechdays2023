tableextension 50001 "ItemTableExt" extends Item
{
    fields
    {
        field(50400; "Weight"; Decimal)
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