package pe.edu.upeu.calcxml

import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.EditText
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {
    private lateinit var txtResult:EditText
    private var val1=0.0
    private var val2=0.0
    private var oper=""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)

        txtResult=findViewById(R.id.txtResultado)
        ejecutar()


        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
    }

    private fun ejecutar(){
        var botones= arrayOf(R.id.btn0,R.id.btn1, R.id.btn2, R.id.btn3, R.id.btn4,
            R.id.btn5, R.id.btn6, R.id.btn7, R.id.btn8,
            R.id.btn9, R.id.btnPunto, R.id.btnBorrar)
        for (b in botones){
            val button=findViewById<Button>(b)
            button.setOnClickListener { accion(button) }
        }
    }

    private fun digitar(valor:String){
        txtResult.append(valor)
    }

    private fun accion(view:View){
        when(view.id){
            R.id.btn0,R.id.btn1, R.id.btn2, R.id.btn3, R.id.btn4,
            R.id.btn5, R.id.btn6, R.id.btn7, R.id.btn8,
            R.id.btn9, R.id.btnPunto->{  var button=findViewById<Button>(view.id)
            digitar(button.text.toString())
            }

            R.id.btnSuma, R.id.btnMulti, R.id.btnResta, R.id.dtnDiv->{
                var button=findViewById<Button>(view.id)
                operacion(button.text.toString())
            }
            R.id.btnIgual->{
                calcularResult()
            }

        }
    }


    private fun calcularResult(){
        val2=txtResult.text.toString().toDouble()
        var result=when(oper){
            "+"->val1+val2
            "-"->val1-val2
            "*"->val1*val2
            "/"->val1/val2
            else ->val2
        }
        txtResult.setText(result.toString())
        oper=""
    }

    private fun operacion(operador:String){
        oper=operador
        val1=txtResult.text.toString().toDouble()
        txtResult.setText("")
    }



}