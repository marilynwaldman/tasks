# Tasks
## Using POW for authentication 

### follow video here:

https://www.youtube.com/watch?v=hnD0Z0LGMIk

also follow documention in POW:

https://github.com/danschultzer/pow


### Adding crud branch to test authenication (branch tasks_crud)

1.  Create a crud named Todos
    
    `mix phx.gen.html Todos Todo todos description:string completed:boolean`
    
2.  Update Router 

    Add the resource to your browser scope in lib/tasks_web/router.ex:
    
        resources "/todos", TodoController
        
3.  Apply the migration

    ` mix ecto.migrate`  
    
4.  Adding route based access control

    add the following to router.ex:
    
     ` pipeline :protected do
          plug Pow.Plug.RequireAuthenticated,
            error_handler: Pow.Phoenix.PlugErrorHandler
        end`
        
    modify the Todo pipeline to navigate through browser and protected:
    
      `scope "/", TasksWeb do
           pipe_through [:browser, :protected]
       
           resources "/todos", TodoController
         end`  
5. mix pow.phoenix.gen.templates  - video 14:30
   so you can style the registration pages
          `mix pow.phoenix.gen.templates`
          
          Please add `web_module: TasksWeb` to your configuration - config.exs.
          
          config :tasks, :pow,
            user: Tasks.Users.User,
            repo: Tasks.Repo,
            web_module: TasksWeb
            
6.  Password resets - video 15:23

https://hexdocs.pm/pow/Mix.Tasks.Pow.Phoenix.Gen.Templates.html 

see extensions



            

             


    


### To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
