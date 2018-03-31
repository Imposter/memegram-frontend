<login-view class="container">
	<div class="row">
		<div class="col s8 offset-s2">
			<div class="card">
				<div class="card-content black-text">
					<span class="card-title">Login</span>
					<p>
						Please enter the email and password for your account to log in. 
						If you have forgotten your password, click <a href="#">here</a>.
					</p>
					<div class="section"></div>
					<div class="row">
						<form class="col s12">
							<div class="row">
								<div class="input-field col s12">
									<input id="email" type="email" class="validate">
									<label for="email">Email</label>
								</div>
								<div class="input-field col s12">
									<input id="password" type="password" class="validate" onkeydown={ keyDown }>
									<label for="password">Password</label>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="card-action">
					<button class="btn waves-effect waves-light" type="submit" onclick={ attemptLogin }>
						Login
						<i class="material-icons right">send</i>
					</button>
					<a class="btn waves-effect waves-light" href="#register">
						Create Account
					</a>
				</div>
			</div>
		</div>
	</div>

	<script>
		/*import { app } from "../scripts/application";

		this.keyDown = async (e) => {
			if (event.key === "Enter") {
				await this.attemptLogin();
			}
		};

		this.attemptLogin = async (e) => {
			var email = $("#email").val();
			var password = $("#password").val();

			try {
				var result = await app.auth.login(email, password);
				
				M.toast({ html: "Logged in successfully!" });

				// TODO: Redirect
			} catch (error) {
				M.toast({ html: error });
			}
		};*/
	</script>
</login-view>