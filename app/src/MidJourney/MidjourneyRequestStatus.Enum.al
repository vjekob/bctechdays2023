enum 50001 "Midjourney Request Status"
{
    Caption = 'Midjourney Request Status';

    value(0; Sent)
    {
        Caption = 'Sent';
    }

    value(1; Pending)
    {
        Caption = 'Pending';
    }

    value(2; Running)
    {
        Caption = 'Running';
    }

    value(3; Done)
    {
        Caption = 'Done';
    }

    value(4; Error)
    {
        Caption = 'Error';
    }

    value(5; Abandoned)
    {
        Caption = 'Abandoned';
    }
}
