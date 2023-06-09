enum 50003 "MidJourney Http Request Types" implements "MidJourney Http Invoker"
{
    value(1; Imagine)
    {
        implementation = "MidJourney Http Invoker" = "MidJourney Imagine";
    }
    value(2; Result)
    {
        implementation = "MidJourney Http Invoker" = "MidJourney Result";
    }
    value(3; Upscale)
    {
        implementation = "MidJourney Http Invoker" = "MidJourney Upscale";
    }
    value(4; Seed)
    {
        implementation = "MidJourney Http Invoker" = "MidJourney Seed";
    }
    value(5; Describe)
    {
        implementation = "MidJourney Http Invoker" = "MidJourney Describe";
    }
}