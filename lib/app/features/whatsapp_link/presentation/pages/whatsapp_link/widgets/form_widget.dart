import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/entities/whatsapp_link.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/message_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/domain/value_objects/phone_vo.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/states/whatsapp_link_state.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/states/whatsapp_link_store.dart';
import 'package:whatsapp_direct_link/app/features/whatsapp_link/presentation/pages/whatsapp_link/widgets/load_button_widget.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final controller = Modular.get<WhatsappLinkStore>();
  final formKey = GlobalKey<FormState>();

  final phoneVO = PhoneVO();
  final messageVO = MessageVO();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
       if (controller.value is SuccessWhatsappLinkState) {
        formKey.currentState?.reset();
        final url = (controller.value as SuccessWhatsappLinkState).url;
        Modular.to.pushNamed('/result/', arguments: url);
      
      } else if (controller.value is ErrorWhatsappLinkState) {
        final message = (controller.value as ErrorWhatsappLinkState).message;
        Fluttertoast.showToast(msg: message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: controller,
        builder: (_, state, child) {
          final isLoading = state is LoadingWhatsappLinkState;
          return Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    enabled: !isLoading,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "(00) 0.0000-000",
                    ),
                    validator: (v) =>
                        phoneVO.validate().fold((l) => l, (r) => null),
                    onSaved: (v) => phoneVO.setValue = v ?? "",
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    enabled: !isLoading,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Digite uma mensagem.",
                    ),
                    validator: (v) =>
                        messageVO.validate().fold((l) => "", (r) => null),
                    onSaved: (v) => messageVO.setValue = v,
                  ),
                  const SizedBox(height: 45),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: !isLoading
                          ? () => generateLinkWhatsapp(state: state)
                          : null,
                      child: !isLoading
                          ? const Text("GERAR LINK")
                          : const LoadButtonWidget(),
                    ),
                  )
                ]),
          );
        });
  }

  void generateLinkWhatsapp({required WhatsappLinkState state}) async {
    formKey.currentState?.save();
    if (formKey.currentState!.validate()) {
      await controller.getUrlGenerate(
          whatsappLink: WhatsappLink(phone: phoneVO, message: messageVO
      ));
    }
  }
}
