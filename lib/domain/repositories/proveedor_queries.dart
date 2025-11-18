class ProveedorQueries {
  static const String proveedores = r'''
    query {
      proveedores {
        id_proveedor
        rfc
        razon_social
        nombre_comercial
        tipo_persona { id_tipo_persona clave descripcion }
        telefono
        correo_electronico
        pagina_web
        contacto_nombre
        contacto_puesto
        calle
        numero_exterior
        numero_interior
        colonia
        municipio
        estado
        pais
        codigo_postal
        banco
        cuenta_bancaria
        clabe
        tipo_cuenta { id_tipo_cuenta clave descripcion }
        moneda { id_moneda clave descripcion simbolo }
        uso_cfdi
        metodo_pago
        forma_pago
        dias_credito
        limite_credito
        retencion_iva
        retencion_isr
        activo
        fecha_alta
        fecha_actualizacion
        notas
        responsable_legal_nombre
        responsable_legal_puesto
        responsable_legal_telefono
        responsable_legal_correo
        responsable_legal_identificacion
        responsable_legal_rfc
        creado_por
        actualizado_por
      }
    }
  ''';

  static const String proveedor = r'''
    query ($id_proveedor: Int!) {
      proveedor(id_proveedor: $id_proveedor) {
        id_proveedor
        rfc
        razon_social
        nombre_comercial
        tipo_persona { id_tipo_persona clave descripcion }
        telefono
        correo_electronico
        pagina_web
        contacto_nombre
        contacto_puesto
        calle
        numero_exterior
        numero_interior
        colonia
        municipio
        estado
        pais
        codigo_postal
        banco
        cuenta_bancaria
        clabe
        tipo_cuenta { id_tipo_cuenta clave descripcion }
        moneda { id_moneda clave descripcion simbolo }
        uso_cfdi
        metodo_pago
        forma_pago
        dias_credito
        limite_credito
        retencion_iva
        retencion_isr
        activo
        fecha_alta
        fecha_actualizacion
        notas
        responsable_legal_nombre
        responsable_legal_puesto
        responsable_legal_telefono
        responsable_legal_correo
        responsable_legal_identificacion
        responsable_legal_rfc
        creado_por
        actualizado_por
      }
    }
  ''';

  static const String tipoPersonas = '''
    query {
      tipoPersonas {
        id_tipo_persona
        clave
        descripcion
      }
    }
  ''';

  static const String tipoPersona = r'''
    query ($id_tipo_persona: Int!) {
      tipoPersona(id_tipo_persona: $id_tipo_persona) {
        id_tipo_persona
        clave
        descripcion
      }
    }
  ''';

  static const String tipoCuentas = r'''
    query {
      tipoCuentas {
        id_tipo_cuenta
        clave
        descripcion
      }
    }
  ''';

  static const String tipoCuenta = r'''
    query ($id_tipo_cuenta: Int!) {
      tipoCuenta(id_tipo_cuenta: $id_tipo_cuenta) {
        id_tipo_cuenta
        clave
        descripcion
      }
    }
  ''';

  static const String monedas = r'''
    query {
      monedas {
        id_moneda
        clave
        descripcion
        simbolo
      }
    }
  ''';

  static const String moneda = r'''
    query ($id_moneda: Int!) {
      moneda(id_moneda: $id_moneda) {
        id_moneda
        clave
        descripcion
        simbolo
      }
    }
  ''';

  static const String createProveedor = r'''
    mutation ($input: CreateProveedorInput!) {
      createProveedor(input: $input) {
        id_proveedor
        rfc
        razon_social
        nombre_comercial
        tipo_persona { id_tipo_persona clave descripcion }
        telefono
        correo_electronico
        pagina_web
        contacto_nombre
        contacto_puesto
        calle
        numero_exterior
        numero_interior
        colonia
        municipio
        estado
        pais
        codigo_postal
        banco
        cuenta_bancaria
        clabe
        tipo_cuenta { id_tipo_cuenta clave descripcion }
        moneda { id_moneda clave descripcion simbolo }
        uso_cfdi
        metodo_pago
        forma_pago
        dias_credito
        limite_credito
        retencion_iva
        retencion_isr
        activo
        fecha_alta
        fecha_actualizacion
        notas
        responsable_legal_nombre
        responsable_legal_puesto
        responsable_legal_telefono
        responsable_legal_correo
        responsable_legal_identificacion
        responsable_legal_rfc
        creado_por
        actualizado_por
      }
    }
  ''';


  static const String updateProveedor = r'''
    mutation ($id_proveedor: Int!, $input: CreateProveedorInput!) {
      updateProveedor(id_proveedor: $id_proveedor, input: $input) {
        id_proveedor
        rfc
        razon_social
        nombre_comercial
        tipo_persona { id_tipo_persona clave descripcion }
        telefono
        correo_electronico
        pagina_web
        contacto_nombre
        contacto_puesto
        calle
        numero_exterior
        numero_interior
        colonia
        municipio
        estado
        pais
        codigo_postal
        banco
        cuenta_bancaria
        clabe
        tipo_cuenta { id_tipo_cuenta clave descripcion }
        moneda { id_moneda clave descripcion simbolo }
        uso_cfdi
        metodo_pago
        forma_pago
        dias_credito
        limite_credito
        retencion_iva
        retencion_isr
        activo
        fecha_alta
        fecha_actualizacion
        notas
        responsable_legal_nombre
        responsable_legal_puesto
        responsable_legal_telefono
        responsable_legal_correo
        responsable_legal_identificacion
        responsable_legal_rfc
        creado_por
        actualizado_por
      }
    }
  ''';

  static const String removeProveedor = r'''
      mutation ($id_proveedor: Int!) {
        removeProveedor(id_proveedor: $id_proveedor)
      }
  ''';

  static const String createTipoPersona = r'''
    mutation ($clave: String!, $descripcion: String!) {
      createTipoPersona(clave: $clave, descripcion: $descripcion) {
        id_tipo_persona
        clave
        descripcion
      }
    }
  ''';

  static const String updateTipoPersona = r'''
    mutation ($id_tipo_persona: Int!, $clave: String!, $descripcion: String!) {
      updateTipoPersona(id_tipo_persona: $id_tipo_persona, clave: $clave, descripcion: $descripcion) {
        id_tipo_persona
        clave
        descripcion
      }
    }
  ''';

  static const String removeTipoPersona = r'''
    mutation ($id_tipo_persona: Int!) {
      removeTipoPersona(id_tipo_persona: $id_tipo_persona)
    }
  ''';


  static const String createTipoCuenta = r'''
    mutation ($clave: String!, $descripcion: String!) {
      createTipoCuenta(clave: $clave, descripcion: $descripcion) {
        id_tipo_cuenta
        clave
        descripcion
      }
    }
  ''';

  static const String updateTipoCuenta = r'''
    mutation ($id_tipo_cuenta: Int!, $clave: String!, $descripcion: String!) {
      updateTipoCuenta(id_tipo_cuenta: $id_tipo_cuenta, clave: $clave, descripcion: $descripcion) {
        id_tipo_cuenta
        clave
        descripcion
      }
    }
  ''';

  static const String removeTipoCuenta = r'''
    mutation ($id_tipo_cuenta: Int!) {
      removeTipoCuenta(id_tipo_cuenta: $id_tipo_cuenta)
    }
  ''';


  static const String createMoneda = r'''
    mutation ($clave: String!, $descripcion: String!, $simbolo: String) {
      createMoneda(clave: $clave, descripcion: $descripcion, simbolo: $simbolo) {
        id_moneda
        clave
        descripcion
        simbolo
      }
    }
  ''';

  static const String updateMoneda = r'''
    mutation ($id_moneda: Int!, $clave: String!, $descripcion: String!, $simbolo: String) {
      updateMoneda(id_moneda: $id_moneda, clave: $clave, descripcion: $descripcion, simbolo: $simbolo) {
        id_moneda
        clave
        descripcion
        simbolo
      }
    }
  ''';

  static const String removeMoneda = r'''
    mutation ($id_moneda: Int!) {
      removeMoneda(id_moneda: $id_moneda)
    }
  ''';
  
}