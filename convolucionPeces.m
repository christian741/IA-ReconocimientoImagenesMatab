function varargout = convolucionPeces(varargin)
% CONVOLUCIONPECES MATLAB code for convolucionPeces.fig
%      CONVOLUCIONPECES, by itself, creates a new CONVOLUCIONPECES or raises the existing
%      singleton*.
%
%      H = CONVOLUCIONPECES returns the handle to a new CONVOLUCIONPECES or the handle to
%      the existing singleton*.
%
%      CONVOLUCIONPECES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONVOLUCIONPECES.M with the given input arguments.
%
%      CONVOLUCIONPECES('Property','Value',...) creates a new CONVOLUCIONPECES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before convolucionPeces_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to convolucionPeces_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help convolucionPeces

% Last Modified by GUIDE v2.5 26-Oct-2020 15:56:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @convolucionPeces_OpeningFcn, ...
                   'gui_OutputFcn',  @convolucionPeces_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

end
% --- Executes just before convolucionPeces is made visible.
function convolucionPeces_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to convolucionPeces (see VARARGIN)

% Choose default command line output for convolucionPeces
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes convolucionPeces wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.imagenTitulo);
handles.imagen=imread('logo.png');
imagesc(handles.imagen)
axis off;

set(handles.txt_alfa,'string','0.9');
set(handles.txt_ocultas,'string','20');
set(handles.txt_beta,'string','0.9');
set(handles.txt_error,'string','0.000000001');
%  k = [1 1 1;1 1 1; 1 1 1]; % Desenfoque
%  k = [0 -1 0;-1 5 -1; 0 -1 0]; % Enfoque
%  k = [0 0 0; -1 1 0; 0 0 0]; % Realce Bordes
%  k = [-2 -1 0; -1 1 1; 0 1 2] % Repujado
%  k = [0 1 0; 1 -4 1; 0 1 0] % Deteccion de bordes
%  k = [-1 0 1; -2 0 2;-1 0 1]; % Filtro tipo sobel
%  k = [1 -2 1; -2 5 -2; 1 -2 1]; % Filtro tipo Sharpen
%  k = [1 1 1; 1 -2 1; -1 -1 -1]; % Filtro Norte
%  k = [-1 1 1; -1 -2 1; -1 1 1]; % Filtro Este
%  k = [1 2 3 1 1; 2 7 11 7 2; 3 11 17 11 3; 2 7 11 7 2; 1 2 3 2 1]; % Filtro tipo Gauss
strings = {'Seleccione Filtro ','Desenfoque','Enfoque','Realce Bordes','Repujado','Deteccion de bordes','Filtro tipo sobel','Filtro tipo Sharpen','Filtro Norte','Filtro Este','Filtro tipo Gauss'};
handles.dropdown.String = strings;
strings2 = {'Seleccione Color ','Rojo','Verde','Azul'};
handles.dropdown2.String = strings2;
array1 = [];
array=[];
set(handles.clean,'Visible','off');
%Lectura imagen
img1=imread('trucha.jpg');
img2=imread('cirujano.png');
%Cambiar tamaño imagen
trucha=imresize(img1,[200 200]);
cirujano=imresize(img2,[200 200]);

pez1=im2bw(trucha);
pez2=im2bw(cirujano);

disp(pez1);
array1=pez1;
array2=pez2;
setGlobalArray1(array1);
setGlobalArray2(array2);


end
% --- Outputs from this function are returned to the command line.
function varargout = convolucionPeces_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in btn_iniciar.
function btn_iniciar_Callback(hObject, eventdata, handles)
end

% --- Executes on button press in seleccionImagen.
function seleccionImagen_Callback(hObject, eventdata, handles)
% hObject    handle to seleccionImagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global imagen1;
lista=get(handles.dropdown, 'string');
valor=get(handles.dropdown, 'value');
valor2=get(handles.dropdown2, 'value');
alfaE = str2double(get(handles.txt_alfa,'String'));
ocultasE= str2double(get(handles.txt_ocultas,'String'));
betaE = str2double(get(handles.txt_beta,'String'));
errorE= str2double(get(handles.txt_error,'String'));
if(valor==1)
    f = warndlg('Seleccione un filtro','Alerta');
    return;
end
if(valor2==1)
    f = warndlg('Seleccione un Color','Alerta');
    return;
end
if(alfaE==0 || ocultasE==0 || betaE==0 || errorE==0)
    f = warndlg('Datos vacios','Alerta');
    return;
end
archivo=uigetfile('*.jpg','Abrir imagen');



imagenbuena=imread(fullfile(archivo));
axes(handles.imagen1);
imagesc(imagenbuena);
imagenbuena=imresize(imagenbuena,[200 200]);


axis off;
prueba = im2bw(imagenbuena);
array1 = getGlobalArray1();
array2 =getGlobalArray2();

if(array1==prueba)
    respuesta = 1;
elseif(array2==prueba)
    respuesta = 2;
else
    respuesta = 3;
end
%disp('alfa'+alfa);


%disp(lista);
disp(valor);

switch(valor2)
    case 2
        color = 2; %rojo
    case 3
        color = 3;% verde
    case 4
        color = 4;%azul
end
switch(valor)
   
   case 2
     k = [1 1 1;1 1 1; 1 1 1]; % Desenfoque
    
   case 3
     k = [0 -1 0;-1 5 -1; 0 -1 0]; % Enfoque
    
   case 4
    k = [0 0 0; -1 1 0; 0 0 0]; % Realce Bordes
  
   case 5
     k = [-2 -1 0; -1 1 1; 0 1 2] % Repujado
   
   case 6
     k = [0 1 0; 1 -4 1; 0 1 0] % Deteccion de bordes
   
   case 7
        k = [-1 0 1; -2 0 2;-1 0 1]; % Filtro tipo sobel
   
       
   case 8
      k = [1 -2 1; -2 5 -2; 1 -2 1]; % Filtro tipo Sharpen
 
    
   case 9
       k = [1 1 1; 1 -2 1; -1 -1 -1]; % Filtro Norte
    
   case 10
       k = [-1 1 1; -1 -2 1; -1 1 1]; % Filtro Este
    
   case 11
       k = [1 2 3 1 1; 2 7 11 7 2; 3 11 17 11 3; 2 7 11 7 2; 1 2 3 2 1]; % Filtro tipo Gauss
end

tamano = size(k);
c=0;
for i=1:tamano(1)
    for j=1:tamano(2)
        c=c+k(i,j);
    end
end
if(c==0)
    c=1;
end
binario = 0;
if(color==2)
    Imrojo=imagenbuena(:,:,1);
    axes(handles.axes5);
    imshow(Imrojo);
    axis off;
    binario= double(imagenbuena(:,:,1));
    
    %binario=im2bw(Imrojo);
    %imshow(Imrojo); imtool(Imrojo);
elseif(color==3)
    %imshow(Imverde); imtool(Imverde);
    Imverde=imagenbuena(:,:,2);
    axes(handles.axes5);
    imshow(Imverde);
    binario= double(imagenbuena(:,:,2));
   
    %binario=im2bw(Imverde);
    axis off;
elseif(color==4)
    %imshow(Imazul); imtool(Imazul);
    Imazul=imagenbuena(:,:,3);
    axes(handles.axes5);
    imshow(Imazul);
    binario= double(imagenbuena(:,:,3));
    %binario=im2bw(Imazul);
    axis off;
end

matrizAux=double(padarray(binario,[1 1]));
s=size(matrizAux);
result=aplicarFiltro(k,s,c,matrizAux);
x = convertirVector(result);
axes(handles.tabla1);
imshow(uint8(result));


%yo=backprogation(x,alfa,ocultas,beta,error);
disp(x);
disp(alfaE);
disp(ocultasE);
disp(betaE);
disp(errorE);

yd = [1; 0;] % Matriz deseada
%-------------
%se divide para hacerlo 1
%---------------
% for i=1:length(x)
%     for j=1:entradas
%         if(x(i,j)~=0)
%             x(i,j)=x(i,j)/x(i,j);
%         end
%     end
% end
%-------------------------------------------------
% Definicion de la Arquitectura Manual de la RED
%-------------------------------------------------
entradas=400;
ocultas=ocultasE;
salidas=1;%neuronas salidas
patron=1;%patrones

alfa = alfaE; %coeficiente de aprendizaje
betha = betaE; %Permite el Momentum
%--------------------------------
%   Arrays para diagramar
%--------------------------------
casosVsET = [];
arrayET=[];
arrayPesosWh=[];
arrayPesosWo=[];

%---------------------------------------
%       PESOS aleatorios de las capas
%---------------------------------------
%         Entrada y de Oculta
wh = random('Normal',0,1,1,(entradas*ocultas));
th = random('Normal',0,1,1,ocultas);
%        Oculta y de salida
wo = random('Normal',0,1,1,(ocultas*salidas));
tk = random('Normal',0,1,1,salidas);
%------------------------------------------------
%        Pesos auxiliares para calculos de delta
%        se le asigna el mismo tamaño para acumular
whAux = wh;
woAux = wo;
thAux = th;
tkAux = tk;

%------------------------------------
%        Ciclo total de la red
%---------------------------------
casosEntrenamiento = 0; 

%------------------------------------
%       Errorees de la red
%---------------------------------
errorTotal = 0;
errorEsperado =errorE;

error= [0];
errorAuxiliar=[0];

% %---------------------------------------
% %    Comienzo del entrenamiento
% %-----------------------------------------
while true
    errorTotal=0;
    errorAuxiliar=0;
    %----------------------------------
    %       Calculo por patron
    %----------------------------------
    for p=1:patron
        %-----------------------------
        %    Calculo NET ocultas
        %------------------------------
        acumulador=1;
        for j=1:ocultas
            for i=1:entradas
                if i==1
                    nethj(j)=x(p,i)*wh(acumulador)+th(j);
                else
                    nethj(j)=nethj(j)+x(p,i)*wh(acumulador);
                end
                acumulador=acumulador+1;
            end
            yhj(j) = 1/(1+exp(-nethj(j)));
        end
        %-----------------------------
        %    Calculo NET Salidas
        %------------------------------
        acumulador=1;
        for k=1:salidas
            for j=1:ocultas
                if j==1
                    netok(k)=yhj(j)*wo(acumulador)+tk(k);
                else
                    netok(k)=netok(k)+yhj(j)*wo(acumulador);
                end
                acumulador=acumulador+1;
            end
            yok(p,k) = 1/(1+exp(-netok(k)));
        end
        %--------------------------------------------
        %           BAKCPROPAGATION
        %--------------------------------------------
        %      Calculo de Delta Error Salida
        %--------------------------------------------
        for k=1:1:salidas
            dok(p,k)=(yd(p,k)-yok(p,k))*yok(p,k)*(1-yok(p,k));
        end

        %--------------------------------------------
        %      Calculo de erroresParciales Ocultas
        %--------------------------------------------
        acumulador=1;
        for k=1:salidas
            for j=1:ocultas
                for i=1:1:entradas
                    dhj(j,i)=x(p,i)*(1-x(p,i))*dok(p,k)*wo(acumulador);
                end
                acumulador=acumulador+1;
            end
        end
        %--------------------------------------------
        %      Actualización de pesos salida
        %--------------------------------------------
        acumulador=1;
        for k=1:salidas
            for j=1:ocultas
                wo(acumulador)=wo(acumulador)+alfa*dok(p,k)*yhj(j)+((wo(acumulador)-woAux(acumulador))*betha);
                acumulador=acumulador+1;
            end
            tk(k)=tk(k)+alfa*dok(p,k)+((tk(k)-tkAux(k))*betha);
        end
        
        woAux = wo;
        tkAux = tk;
        %--------------------------------------------
        %      Actualización de pesos entrada
        %--------------------------------------------
        acumulador=1;
        for j=1:ocultas
            for i=1:entradas
                wh(acumulador)=wh(acumulador)+alfa*dhj(j,i)*x(p,i)+((wh(acumulador)-whAux(acumulador))*betha);
                dhj(j,i)=dhj(j,i)+dhj(j,i);
                acumulador=acumulador+1;
            end
            th(j)=(th(j)+alfa*(dhj(j,entradas))/entradas)+((th(j)-thAux(j))*betha);
        end
        whAux = wh;
        thAux = th;
        
        %--------------------------------------------
        %      Validar el error
        %--------------------------------------------
        for k=1:salidas
            error(p,k)=0.5*(dok(p,k))^2;
        end
        
        for k=1:salidas
            errorAuxiliar=errorAuxiliar+error(p,k);
        end

        errorAuxiliar=errorAuxiliar/salidas;
        
        errorTotal=errorAuxiliar+errorTotal;
        
    end
    
    for p=1:patron
        for k=1:salidas
            yo(p,k)=[yok(p,k)]
        end
    end
    
    disp(casosEntrenamiento);
    errorTotal=errorTotal/patron;
    casosEntrenamiento=casosEntrenamiento+1;
    disp(casosEntrenamiento);
    casosVsET(casosEntrenamiento)=casosEntrenamiento;
    arrayET(casosEntrenamiento)=errorTotal;
%     arrayPesosWh(casosEntrenamiento) = whAux;
%     arrayPesosWo(casosEntrenamiento) = woAux;
    
    %axes(handles.tabla1);
    if errorTotal<errorEsperado
        break;
    end
end
%---------------------------------------
%    fin del entrenamiento
%-----------------------------------------
    axes(handles.imagen2);
    plot(casosVsET,arrayET,'*');
    title('Casos vs Error');
    xlabel('Casos');
    ylabel('Error');
    grid on; 
    hold on;
    
   
    if(respuesta==1)
        set(handles.lbl_descripcion,'string','es una trucha agua dulce');
    end
    if(respuesta==2)
        set(handles.lbl_descripcion,'string','es una cirujano agua salada');
    end
    if(respuesta==3)
        set(handles.lbl_descripcion,'string','No es ninguno');
    end
    
   
set(handles.clean,'Visible','on');
 set(handles.seleccionImagen,'Visible','off');


end
function y= aplicarFiltro(k,s,c, matrizAux)

    result=matrizAux*0;

    for i=2: s(1)-1
        for j=2: s(2)-1
            ventana=matrizAux(i-1:i+1, j-1:j+1);
            prod=ventana .* k;
            pix=(1/c)*sum(sum(prod));
            result(i,j)=pix;
        end
    end
    result(s(1),:)=[];
    result(:,s(2))=[];
    result(1,:)=[];
    result(:,1)=[];

    y=result;
end
function y = convertirVector(matrizResul)
    matrizIndex=random('Normal',0,1,200,200);
    matrizBin=im2bw(matrizResul);
    v=times(matrizIndex,matrizBin);

    for i=1:length(v)
        aux=0;
        aux2=0;
        for j=1:length(v)
            aux=aux+v(i,j);
            aux2=aux2+ v(j,i);
            sumFil(i)=aux;
            sumCol(i)=aux2;
        end
    end 

    aux=1;
    for i=1:1:(length(sumFil)+length(sumCol))
        if i<=length(sumFil)
         y(i)=sumFil(i);
        else
         y(i)=sumCol(aux);
         aux=aux+1;
        end
    end
    y=im2bw(y);   
end

% 
% --- Executes on selection change in dropdown.
function dropdown_Callback(hObject, eventdata, handles)

% hObject    handle to dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdown contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdown

end
% --- Executes during object creation, after setting all properties.
function dropdown_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

function  yo=backprogation(x,alfaE,ocultasE,betaE,errorE)
disp(x);
disp(alfaE);
disp(ocultasE);
disp(betaE);
disp(errorE);

yd = [1; 0;] % Matriz deseada
%-------------
%se divide para hacerlo 1
%---------------
% for i=1:length(x)
%     for j=1:entradas
%         if(x(i,j)~=0)
%             x(i,j)=x(i,j)/x(i,j);
%         end
%     end
% end
%-------------------------------------------------
% Definicion de la Arquitectura Manual de la RED
%-------------------------------------------------
entradas=400;
ocultas=ocultasE;
salidas=1;%neuronas salidas
patron=1;%patrones

alfa = alfaE; %coeficiente de aprendizaje
betha = betaE; %Permite el Momentum
%--------------------------------
%   Arrays para diagramar
%--------------------------------
casosVsET = [];
arrayET=[];
arrayPesos=[];
%---------------------------------------
%       PESOS aleatorios de las capas
%---------------------------------------
%         Entrada y de Oculta
wh = random('Normal',0,1,1,(entradas*ocultas));
th = random('Normal',0,1,1,ocultas);
%        Oculta y de salida
wo = random('Normal',0,1,1,(ocultas*salidas));
tk = random('Normal',0,1,1,salidas);
%------------------------------------------------
%        Pesos auxiliares para calculos de delta
%        se le asigna el mismo tamaño para acumular
whAux = wh;
woAux = wo;
thAux = th;
tkAux = tk;

%------------------------------------
%        Ciclo total de la red
%---------------------------------
casosEntrenamiento = 0; 

%------------------------------------
%       Errorees de la red
%---------------------------------
errorTotal = 0;
errorEsperado =errorE;

error= [0];
errorAuxiliar=[0];

% %---------------------------------------
% %    Comienzo del entrenamiento
% %-----------------------------------------
while true
    errorTotal=0;
    errorAuxiliar=0;
    %----------------------------------
    %       Calculo por patron
    %----------------------------------
    for p=1:patron
        %-----------------------------
        %    Calculo NET ocultas
        %------------------------------
        acumulador=1;
        for j=1:ocultas
            for i=1:entradas
                if i==1
                    nethj(j)=x(p,i)*wh(acumulador)+th(j);
                else
                    nethj(j)=nethj(j)+x(p,i)*wh(acumulador);
                end
                acumulador=acumulador+1;
            end
            yhj(j) = 1/(1+exp(-nethj(j)));
        end
        %-----------------------------
        %    Calculo NET Salidas
        %------------------------------
        acumulador=1;
        for k=1:salidas
            for j=1:ocultas
                if j==1
                    netok(k)=yhj(j)*wo(acumulador)+tk(k);
                else
                    netok(k)=netok(k)+yhj(j)*wo(acumulador);
                end
                acumulador=acumulador+1;
            end
            yok(p,k) = 1/(1+exp(-netok(k)));
        end
        %--------------------------------------------
        %           BAKCPROPAGATION
        %--------------------------------------------
        %      Calculo de Delta Error Salida
        %--------------------------------------------
        for k=1:1:salidas
            dok(p,k)=(yd(p,k)-yok(p,k))*yok(p,k)*(1-yok(p,k));
        end

        %--------------------------------------------
        %      Calculo de erroresParciales Ocultas
        %--------------------------------------------
        acumulador=1;
        for k=1:salidas
            for j=1:ocultas
                for i=1:1:entradas
                    dhj(j,i)=x(p,i)*(1-x(p,i))*dok(p,k)*wo(acumulador);
                end
                acumulador=acumulador+1;
            end
        end
        %--------------------------------------------
        %      Actualización de pesos salida
        %--------------------------------------------
        acumulador=1;
        for k=1:salidas
            for j=1:ocultas
                wo(acumulador)=wo(acumulador)+alfa*dok(p,k)*yhj(j)+((wo(acumulador)-woAux(acumulador))*betha);
                acumulador=acumulador+1;
            end
            tk(k)=tk(k)+alfa*dok(p,k)+((tk(k)-tkAux(k))*betha);
        end
        woAux = wo;
        tkAux = tk;
        %--------------------------------------------
        %      Actualización de pesos entrada
        %--------------------------------------------
        acumulador=1;
        for j=1:ocultas
            for i=1:entradas
                wh(acumulador)=wh(acumulador)+alfa*dhj(j,i)*x(p,i)+((wh(acumulador)-whAux(acumulador))*betha);
                dhj(j,i)=dhj(j,i)+dhj(j,i);
                acumulador=acumulador+1;
            end
            th(j)=(th(j)+alfa*(dhj(j,entradas))/entradas)+((th(j)-thAux(j))*betha);
        end
        whAux = wh;
        thAux = th;
        %--------------------------------------------
        %      Validar el error
        %--------------------------------------------
        for k=1:salidas
            error(p,k)=0.5*(dok(p,k))^2;
        end
        
        for k=1:salidas
            errorAuxiliar=errorAuxiliar+error(p,k);
        end

        errorAuxiliar=errorAuxiliar/salidas;
        
        errorTotal=errorAuxiliar+errorTotal;
        
    end
    
    for p=1:patron
        for k=1:salidas
            yo(p,k)=[yok(p,k)]
        end
    end
    
    disp(casosEntrenamiento);
    errorTotal=errorTotal/patron;
    casosEntrenamiento=casosEntrenamiento+1;
    disp(casosEntrenamiento);
    casosVsET(casosEntrenamiento)=casosEntrenamiento;
    arrayET(casosEntrenamiento)=errorTotal;
%     arrayPesosWh(casosEntrenamiento) = whAux;
%     arrayPesosWo(casosEntrenamiento) = woAux;
    
    %axes(handles.tabla1);
    if errorTotal<errorEsperado
        break;
    end
end
%---------------------------------------
%    fin del entrenamiento
%-----------------------------------------

pintarDiagramas (casosVsET,arrayET,arrayPesos);
end

function pintarDiagramas (casosVsET,arrayET,arrayPesos)
    
    plot(casosVsET,arrayET,'*');
    title('Casos vs Error');
    xlabel('Casos');
    ylabel('Error');
    grid on; 
    hold on;
    
    plot(casosVsET,arrayET,'*');
    title('Casos vs Error');
    xlabel('Casos');
    ylabel('Error');
    grid on; 
    hold on;
   
end



function txt_alfa_Callback(hObject, eventdata, handles)
% hObject    handle to txt_alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_alfa as text
%        str2double(get(hObject,'String')) returns contents of txt_alfa as a double
end

% --- Executes during object creation, after setting all properties.
function txt_alfa_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_alfa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end

function txt_beta_Callback(hObject, eventdata, handles)
% hObject    handle to txt_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_beta as text
%        str2double(get(hObject,'String')) returns contents of txt_beta as a double
end

% --- Executes during object creation, after setting all properties.
function txt_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function txt_error_Callback(hObject, eventdata, handles)
% hObject    handle to txt_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_error as text
%        str2double(get(hObject,'String')) returns contents of txt_error as a double

end

% --- Executes during object creation, after setting all properties.
function txt_error_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_error (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function txt_ocultas_Callback(hObject, eventdata, handles)
% hObject    handle to txt_ocultas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_ocultas as text
%        str2double(get(hObject,'String')) returns contents of txt_ocultas as a double
end

% --- Executes during object creation, after setting all properties.
function txt_ocultas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_ocultas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in list_pesos.
function list_pesos_Callback(hObject, eventdata, handles)
% hObject    handle to list_pesos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_pesos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_pesos

end
% --- Executes during object creation, after setting all properties.
function list_pesos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_pesos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on selection change in dropdown2.
function dropdown2_Callback(hObject, eventdata, handles)
% hObject    handle to dropdown2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dropdown2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropdown2

end
% --- Executes during object creation, after setting all properties.
function dropdown2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropdown2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function setGlobalArray1(variable)
    global arr;
    arr=variable;
end

function arr=getGlobalArray1()
    global arr;
    arr=arr;
end

function setGlobalArray2(variable)
    global arr2;
    arr2=variable;
end

function arr2=getGlobalArray2()
    global arr2;
    arr2=arr2;
end


% --- Executes on button press in clean.
function clean_Callback(hObject, eventdata, handles)
% hObject    handle to clean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of clean
    cla(handles.imagen2);
    cla(handles.imagen1);
    cla(handles.axes5);
    cla(handles.tabla1);
    cla(handles.lbl_descripcion);
    set(handles.clean,'Visible','off');
    set(handles.seleccionImagen,'Visible','on');
    
end