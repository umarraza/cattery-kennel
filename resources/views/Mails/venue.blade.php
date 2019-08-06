<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<body>
    <div class="row">
        <div class="col-lg-12 text-center">

            <h1>Hi ! A new booking have been registered.</h1>
            <h2>Booker Information</h2>
            <h4>Name: <span style="display:inline">{{$customer->bookerName}}</span> </h4> 
            <h4>Name: <span style="display:inline">{{$customer->email}}</span> </h4> 
            <h4>Name: <span style="display:inline">{{$customer->phoneNumber}}</span> </h4> 
            <h4>Name: <span style="display:inline">{{$booking->checkIn}}</span> </h4> 
            <h4>Name: <span style="display:inline">{{$booking->checkOut}}</span> </h4> 
        </div>
    </div>
</body>
</html>