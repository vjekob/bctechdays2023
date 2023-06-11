pageextension 50001 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(PictureURLAzure; Rec."Picture URL")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Picture URL';
                ToolTip = 'Specifies the URL of this item''s picture  (for Midjourney processing).';
            }
        }
    }

    actions
    {
        addlast(Navigation_Item)
        {
            action(Imagine)
            {
                Caption = 'Imagine';
                Image = Picture;
                ApplicationArea = All;
                ToolTip = 'Creates a Midjourney image';
                RunObject = page "Midjourney Imagine";
                RunPageLink = "No." = field("No.");
            }
        }
        addfirst(Promoted)
        {
            actionref(MidjourneyRef; Imagine) { Visible = true; }
        }
    }
}