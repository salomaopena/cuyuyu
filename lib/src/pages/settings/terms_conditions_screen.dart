//@dart=2.9
import 'package:cuyuyu/src/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Termos de condições',
          style: TextStyle(
              color: AppColors.closeColor,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        children: [
          const Text(
            'Termos de uso',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '1.	Termos\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nAo aceder ao Cuyuyu Entregas, concorda em cumprir estes termos de serviço, todas as leis e regulamentos aplicáveis e concorda que é responsável pelo cumprimento de todas as leis locais aplicáveis. Se você não concordar com algum desses termos, está proibido de usar ou aceder este aplicativo. Os materiais contidos neste aplicativo são protegidos pelas leis de direitos autorais e marcas comerciais aplicáveis.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '2.	Uso de licença\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                        text:
                            '\nÉ concedida permissão para baixar temporariamente uma cópia dos materiais (informações ou software) no Cuyuyu Entregas, apenas para visualização transitória pessoal e não comercial. Esta é a concessão de uma licença, não uma transferência de título e, sob esta licença, você não pode:',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 1.2,
                          wordSpacing: 1.2,
                        ),
                        children: [
                          TextSpan(
                            text:
                                '\n\na)	Modificar ou copiar os materiais;             ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\nb)	Usar os materiais para qualquer finalidade comercial ou para exibição pública (comercial ou não comercial);             ',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\nc)	Tentar descompilar ou fazer engenharia reversa de qualquer software contido no Cuyuyu Entregas;',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\nd)	Remover quaisquer direitos autorais ou outras notações de propriedade dos materiais; ou',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\n e)	Transferir os materiais para outra pessoa ou \'espelhe\' os materiais em qualquer outro servidor.',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          ),
                          TextSpan(
                            text:
                                '\n\nEsta licença será automaticamente rescindida se você violar alguma dessas restrições e poderá ser rescindida por Cuyuyu Entregas a qualquer momento. Ao encerrar a visualização desses materiais ou após o término desta licença, você deve apagar todos os materiais baixados em sua posse, seja em formato electrónico ou impresso.',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.2,
                              wordSpacing: 1.2,
                            ),
                          )
                        ]),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '3. Isenção de responsabilidade\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nOs materiais no aplicativo Cuyuyu Entregas são fornecidos \'como estão\'. Cuyuyu Entregas não oferece garantias, expressas ou implícitas, e, por este meio, isenta e nega todas as outras garantias, incluindo, sem limitação, garantias implícitas ou condições de comercialização, adequação a um fim específico ou não violação de propriedade intelectual ou outra violação de direitos. Além disso, o Cuyuyu Entregas não garante ou faz qualquer representação relativa à precisão, aos resultados prováveis ou à confiabilidade do uso dos materiais em seu aplicativo ou de outra forma relacionado a esses materiais ou em sites vinculados a este aplicativo.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '4.	Limitações\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nEm nenhum caso o Cuyuyu Entregas ou seus fornecedores serão responsáveis por quaisquer danos (incluindo, sem limitação, danos por perda de dados ou lucro ou devido a interrupção dos negócios) decorrentes do uso ou da incapacidade de usar os materiais em Cuyuyu Entregas, mesmo que Cuyuyu Entregas ou um representante autorizado da Cuyuyu Entregas tenha sido notificado oralmente ou por escrito da possibilidade de tais danos. Como algumas jurisdições não permitem limitações em garantias implícitas, ou limitações de responsabilidade por danos consequentes ou incidentais, essas limitações podem não se aplicar a você.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '5.	Precisão dos materiais\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nOs materiais exibidos no aplicativo da Cuyuyu Entregas podem incluir erros técnicos, tipográficos ou fotográficos. Cuyuyu Entregas não garante que qualquer material em seu aplicativo seja preciso, completo ou actual. Cuyuyu Entregas pode fazer alterações nos materiais contidos em seu aplicativo a qualquer momento, sem aviso prévio. No entanto, Cuyuyu Entregas não se compromete a actualizar os materiais.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '6.	Links\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nO Cuyuyu Entregas não analisou todos os sites vinculados ao seu aplicativo e não é responsável pelo conteúdo de nenhum site vinculado. A inclusão de qualquer link não implica endosso por Cuyuyu Entregas. O uso de qualquer site vinculado é por conta e risco do usuário.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '7.	Modificações\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nO Cuyuyu Entregas pode revisar estes termos de serviço do aplicativo a qualquer momento, sem aviso prévio. Ao usar este aplicativo, você concorda em ficar vinculado à versão actual desses termos de serviço.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
          const SizedBox(height: 16),
          RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(children: [
              TextSpan(
                  text: '8.	Lei aplicável\n',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          '\nEstes termos e condições são regidos e interpretados de acordo com as leis do Cuyuyu Entregas e você se submete irrevogavelmente à jurisdição exclusiva dos tribunais naquela localidade.',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        height: 1.2,
                        wordSpacing: 1.2,
                      ),
                    ),
                  ]),
            ]),
          ),
        ],
      ),
      // ignore: missing_required_param
    );
  }
}
