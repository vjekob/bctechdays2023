enum 50003 "MidJourney HTTP Request Types" implements "MidJourney HTTP Invoker"
{
    value(1; Imagine)
    {
        implementation = "MidJourney HTTP Invoker" = "MidJourney Imagine";
    }
    value(2; Result)
    {
        implementation = "MidJourney HTTP Invoker" = "MidJourney Result";
    }
    value(3; Upscale)
    {
        implementation = "MidJourney HTTP Invoker" = "MidJourney Upscale";
    }
    value(4; Seed)
    {
        implementation = "MidJourney HTTP Invoker" = "MidJourney Seed";
    }
    value(5; Describe)
    {
        implementation = "MidJourney HTTP Invoker" = "MidJourney Describe";
    }
}