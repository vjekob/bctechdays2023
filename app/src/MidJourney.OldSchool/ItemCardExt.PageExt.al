pageextension 50001 "Item Card Ext" extends "Item Card"
{
    actions
    {
        addlast(Navigation_Item)
        {
            action(UploadMedia)
            {
                Caption = 'Upload Media';
                Promoted = true;
                Image = Picture;
                PromotedOnly = true;
                ApplicationArea = All;
                ToolTip = 'Uploads currently selected media to Azure BLOB storage';

                trigger OnAction()
                var
                    t: Codeunit "Azure BLOB Upload Meth";
                begin
                    t.Upload(Rec.Picture.Item(1));
                end;
            }
        }
    }
}