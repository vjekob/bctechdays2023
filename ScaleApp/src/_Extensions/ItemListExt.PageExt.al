pageextension 60100 "ItemListExt" extends "Item List"
{
    layout
    {
        addfirst(Control1)
        {
            field("Weight"; Rec."Weight")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addfirst(processing)
        {
            action("GetWeight")
            {
                Caption = 'Get Weight';
                Image = GetEntries;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.GetWeight();
                end;
            }

        }
        addfirst(Promoted)
        {
            actionref(GetWeightNew_Promoted; GetWeight)
            {
            }
        }

    }
}