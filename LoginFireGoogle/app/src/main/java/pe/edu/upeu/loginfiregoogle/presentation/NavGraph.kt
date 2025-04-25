package pe.edu.upeu.loginfiregoogle.presentation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable

@Composable
fun AppNavHost(navController: NavHostController) {
    NavHost(navController, startDestination = "signin") {
        composable("signin") { SignInScreen(navController) }
        composable("home") { HomeScreen(navController) }
    }
}
