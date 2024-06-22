var API_ENDPOINT = "${invoke_url}/vacunas";

// AJAX POST request to save vacuna data
document.getElementById("savevacuna").onclick = function(){
    var inputData = {
        "Vacuna_ID": $('#Vacuna_ID').val(),
        "name": $('#name').val(),
        "Fecha": $('#Fecha').val(),
    };
    $.ajax({
        url: API_ENDPOINT,
        type: 'POST',
        data:  JSON.stringify(inputData),
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            document.getElementById("vacunaSaved").innerHTML = "Se salvo la vacuna!";
        },
        error: function () {
            alert("Error saving vacuna data.");
        }
    });
}

// AJAX GET request to retrieve all vacunas
document.getElementById("getvacuna").onclick = function(){  
    $.ajax({
        url: API_ENDPOINT,
        type: 'GET',
        contentType: 'application/json; charset=utf-8',
        success: function (response) {
            $('#Tabla_Vacunas tr').slice(1).remove();
            jQuery.each(response, function(i, data) {          
                $("#Tabla_Vacunas").append("<tr> \
                    <td>" + data['Vacuna_ID'] + "</td> \
                    <td>" + data['name'] + "</td> \
                    <td>" + data['Fecha'] + "</td> \
                    </tr>");
            });
        },
        error: function () {
            alert("Error retrieving vacuna data.");
        }
    });
}
