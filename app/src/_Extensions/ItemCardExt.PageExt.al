pageextension 50001 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(PictureURLAzure; Rec."Picture URL (Azure BLOB)")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Picture URL (Azure BLOB)';
                ToolTip = 'Specifies the URL of this item''s picture in Azure BLOB storage (for Midjourney processing).';
            }
        }
    }

    actions
    {
        addlast(Navigation_Item)
        {
            action(Midjourney)
            {
                Caption = 'Midjourney';
                Image = Picture;
                ApplicationArea = All;
                ToolTip = 'Creates a Midjourney image';
                RunObject = page "Midjourney Image";
                RunPageLink = "No." = field("No.");
            }
            action(MidjourneyJQ)
            {
                Caption = 'Midjourney';
                Image = Picture;
                ApplicationArea = All;
                ToolTip = 'Creates a Midjourney image';
                RunObject = page "Midjourney Image JQ";
                RunPageLink = "No." = field("No.");
            }
        }
        addfirst(Promoted)
        {
            actionref(MidjourneyRef; Midjourney) { Visible = true; }
            actionref(MidjourneyJQRef; MidjourneyJQ) { Visible = true; }
        }
    }
}