<explore-view class="container">

    <post-view each={ posts }>
        
    </post-view>

    <script>
        this.posts = [
            {
                name: "HungryHippo", 
                caption: "This is a very nice Ford Mustang from the game Need for Speed", 
                url: "https://cdnb.artstation.com/p/assets/images/images/002/337/165/medium/mikhail-sharov-27-1080-2.jpg?1460458373",
                topics: [ "Cars", "Ford", "Games", "Need for Speed" ]
            }
        ];

        //import route from "riot-route";

        this.login = function (e) {
            // todo: do the real thing
        };
    </script>
</explore-view>