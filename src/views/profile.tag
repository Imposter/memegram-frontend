<profile-view>
	<!-- TODO: Fix refresh button to right -->

	<ul class="collapsible">
		<li>
			<div class="collapsible-header"><i class="material-icons">filter_drama</i>First</div>
			<div class="collapsible-body"><span>Lorem ipsum dolor sit amet.</span></div>
		</li>
		<li>
			<div class="collapsible-header"><i class="material-icons">place</i>Second</div>
			<div class="collapsible-body"><span>Lorem ipsum dolor sit amet.</span></div>
		</li>
		<li>
			<div class="collapsible-header"><i class="material-icons">whatshot</i>Third</div>
			<div class="collapsible-body"><span>Lorem ipsum dolor sit amet.</span></div>
		</li>
	</ul>

	<script>
		this.on("mount", function () {
			M.AutoInit();
		});
	</script>
</profile-view>