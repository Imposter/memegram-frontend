<app>
	<header>
		<div class="navbar-fixed">
			<nav>
				<div class="nav-wrapper">
					<div class="nav row">
						<div class="col s2">
							<!-- Logo icon -->
							<a href="#" class="brand-logo">
								<img class="logo-icon" src="images/memegram-icon-light.png" />
								<img class="logo-title" src="images/memegram-title-light.png" />
							</a>
						</div>
						
						<div class="col s8">
							<form>
								<div class="input-field">
									<input id="search" type="search" required>
									<label class="label-icon" for="search"><i class="material-icons">search</i></label>
									<i class="material-icons">close</i>
								</div>
							</form>
						</div>

						<a href="#" data-target="side-navigation" class="sidenav-trigger"><i class="material-icons">menu</i></a>
						<div class="col s2 hide-on-med-and-down">
							<ul class="right">
								<li><a href="#"><i class="material-icons">explore</i></a></li>
								<li><a href="#"><i class="material-icons">view_list</i></a></li>
								<li show={ opts.app.services.auth.loggedIn }><a href="#" onclick={ attemptLogout }><i class="material-icons">exit_to_app</i></a></li>
								<li show={ !opts.app.services.auth.loggedIn }><a href="#login"><i class="material-icons">account_circle</i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</nav>
		</div>

		<!-- Sidebar -->
		<!-- TODO: Design -->
		<ul id="side-navigation" class="sidenav">
			<li>
				<div class="user-view">
					<div class="background">
						<!--<img src="images/office.jpg">-->
					</div>
					<!--<a href="#user"><img class="circle" src="images/yuna.jpg"></a>-->
					<a href="#name"><span class="white-text name">John Doe</span></a>
					<a href="#email"><span class="white-text email">jdandturk@gmail.com</span></a>
				</div>
			</li>
			<li><a href="#!"><i class="material-icons">cloud</i>First Link With Icon</a></li>
			<li><a href="#!">Second Link</a></li>
			<li>
				<div class="divider"></div>
			</li>
			<li><a class="subheader">Subheader</a></li>
			<li><a class="waves-effect" href="#!">Third Link With Waves</a></li>
		</ul>
	</header>

	<!-- Body -->
	<main class="grey lighten-5">
		<div class="section"></div>
		<div id="app-body"></div>
	</main>

	<!-- Footer -->
	<footer class="page-footer">
		<div class="container">
			<div class="row">
				<div class="col l6 s12">
					<h5 class="white-text">Footer Content</h5>
					<p class="grey-text text-lighten-4">You can use rows and columns here to organize your footer content.</p>
				</div>
				<div class="col l4 offset-l2 s12">
					<h5 class="white-text">Links</h5>
					<ul>
						<li><a class="grey-text text-lighten-3" href="#rules">Rules</a></li>
						<li><a class="grey-text text-lighten-3" href="#tos">Terms of Service</a></li>
						<li><a class="grey-text text-lighten-3" href="#contact">Contact Us</a></li>
						<li><a class="grey-text text-lighten-3" href="#about">About Us</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="footer-copyright">
			<div class="container">
				Copyright &copy; { opts.app.date.getFullYear() } { opts.app.name }. All Rights Reserved.
			</div>
		</div>
	</footer>

	<script>
		this.on("mount", function () {
			// Setup sidenav
			$("#side-navigation").sidenav();
		});
	</script>

	<script>
		import { app } from "./scripts/application";

		// App handlers
		this.attemptLogout = (e) => {
			// TODO: ...
			console.log("logout!");
		};
	</script>

</app>