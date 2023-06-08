tableextension 50001 "ItemTableExt" extends Item
{
    fields
    {
        field(50000; "Weight"; Decimal)
        {
            Caption = 'Weight';
            DataClassification = CustomerContent;
        }
        field(50001; "Picture In Scene"; Media)
        {
            Caption = 'Picture 2';
            DataClassification = CustomerContent;
        }
        field(50002; "Alternative Picture"; Media)
        {
            Caption = 'Picture 2';
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