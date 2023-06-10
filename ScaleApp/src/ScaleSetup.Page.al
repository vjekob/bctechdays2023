page 60100 "Scale Setup"
{

    PageType = Card;
    SourceTable = "ScaleSetup";
    Caption = 'Scale Setup';
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(Old)
            {
                field("Scale Codeunit"; Rec."Scale Codeunit Id")
                {
                    ApplicationArea = All;
                }
                field("Scale Codeunit Name"; Rec."Scale Codeunit Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(New)
            {
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.get then begin
            Rec.init();
            Rec.Insert();
        end;
    end;

}
