<register-view class="container">
	<div class="row">
		<div class="col s8 offset-s2">
			<div class="card">
				<div class="card-content black-text">
					<span class="card-title">Register</span>
					<p>
						Please enter the email and password to create your account. If you have not already read our terms of service, click
						<a href="#tos">here</a>.
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
									<input id="password" type="password" class="validate">
									<label for="password">Password</label>
								</div>
								<div class="input-field col s12">
									<input id="confirm-password" type="password" class="validate" onkeydown={ keyDown }>
									<label for="confirm-password">Confirm Password</label>
								</div>
								<div class="input-field col s12">
									<label>
										<input id="accept-tos" type="checkbox" class="filled-in" />
										<span>I have read and agree to the <a href="#tos">Terms of Service</a>.</span>
									</label>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="card-action">
					<button class="btn waves-effect waves-light" type="submit" onclick={ attemptRegister }>
						Create Account
						<i class="material-icons right">create</i>
					</button>
					<a class="btn waves-effect waves-light" href="#login">
						Login
					</a>
				</div>
			</div>
		</div>
	</div>

	<script>
		this.keyDown = async (e) => {
			if (event.key === "Enter") {
				await this.attemptRegister();
			}
		};

		this.attemptRegister = async (e) => {
			var email = $("#email").val();
			var password = $("#password").val();

			// TODO: ...
		};
	</script>
</register-view>