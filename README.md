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

7.  Install reset password extension

      `mix pow.extension.ecto.gen.migrations  --extension PowResetPassword`

https://hexdocs.pm/pow/Mix.Tasks.Pow.Phoenix.Gen.Templates.html 

see extensions

8.  extensions: [PowResetPassword, PowEmailConfirmation],
      controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks
      
      per this:  https://github.com/danschultzer/pow/blob/master/README.md
      
9.  Update LIB_PATH/users/user.ex with the extensions:
    
    defmodule MyApp.Users.User do
      use Ecto.Schema
      use Pow.Ecto.Schema
      use Pow.Extension.Ecto.Schema,
        extensions: [PowResetPassword, PowEmailConfirmation]
    
      # ...
    
      def changeset(user_or_changeset, attrs) do
        user_or_changeset
        |> pow_changeset(attrs)
        |> pow_extension_changeset(attrs)
      end
    end    
    
10.  Now router

defmodule MyAppWeb.Router do
  use MyAppWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword]

  # ...

  scope "/" do
    pipe_through :browser

    pow_routes()
    pow_extension_routes()
  end
  
11.Generate views and templates to handle password reset

 `mix pow.extension.phoenix.gen.templates --extension PowResetPassword
 
12.  Add link to reset password - open up sign in template and add link (new.html.eex)
 <span><%= link "Reset password", to: Routes.pow_reset_password_reset_password_path(@conn, :new) %></span>

13. the Mailer

     add file pow_mailer.ex to lib/tasks_web 
     
     use this 
     
     defmodule MyAppWeb.PowMailer do
       use Pow.Phoenix.Mailer
       require Logger
     
       def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
         # Build email struct to be used in `process/1`
     
         %{to: user.email, subject: subject, text: text, html: html}
       end
     
       def process(email) do
         # Send email
     
         Logger.debug("E-mail sent: #{inspect email}")
       end
       
14.  mix pow.extension.phoenix.mailer.gen.templates --extension PowResetPassword

Remember to set up lib/tasks_web.ex with `mailer_view/0` function if you haven't already:

defmodule TasksWeb do
  # ...

  def mailer_view do
    quote do
      use Phoenix.View, root: "lib/tasks_web/templates",
                        namespace: TasksWeb

      use Phoenix.HTML
    end
    
15.  video 26.18  powassent
https://www.youtube.com/watch?v=hnD0Z0LGMIk&t=1262s    

       
     
 

    



            

             


    


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
