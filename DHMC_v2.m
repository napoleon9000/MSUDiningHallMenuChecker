clear
version = 2.4;
% Load lists
url = readList('webpage.txt');
keywords = readList('keywords.txt');
subscripters = readList('subscript.txt');


lineContent = '----------';
doubleLineContent = '========================================';
mailContent = '';
breakfastContent = '';
lunchContent = '';
dinnerContent = '';

for m = 2:size(url,1)
% for m = 7
% Initialize varibles



% Read webpage
    % Write header info
    breakfastContent = char(breakfastContent,lineContent);
    lunchContent = char(lunchContent,lineContent);
    dinnerContent = char(dinnerContent,lineContent);
    breakfastContent = char(breakfastContent,[strtrim(url(m,33:end)),':']);
    lunchContent = char(lunchContent,[strtrim(url(m,33:end)),':']);
    dinnerContent = char(dinnerContent,[strtrim(url(m,33:end)),':']);
    breakfastContent = char(breakfastContent,lineContent);
    lunchContent = char(lunchContent,lineContent);
    dinnerContent = char(dinnerContent,lineContent);
    webpage=webread(strtrim(url(m,:)));
        % Read different time
    exprBreakfast = '<td class="views-field views-field-field-breakfast-menu-value">\s[A-Za-z <>/=-"\s\\]*?</td>';
    exprLunch = '<td class="views-field views-field-field-lunch-menu-value">\s[A-Za-z <>/=-"\s\\]*?</td>';
    exprDinner = '<td class="views-field views-field-field-dinner-menu-value">\s[A-Za-z <>/=-"\s\\]*?</td>';
    exprDish = '>\w[A-Za-z\s]+?<';
    mealContent{1} = regexp(webpage,exprBreakfast,'match');
    mealContent{2} = regexp(webpage,exprLunch,'match');
    mealContent{3} = regexp(webpage,exprDinner,'match');

        % Read dishes
            % i = Breakfast or Lunch or Dinner
    for i = 1:3
        dishContentStr = '';
                % j = Different Place
        for j = 1:size(mealContent{i},2)
            
            dishContent = regexp(mealContent{i}(j),exprDish,'match');
                    % k = Different dishes
            for k = 1:size(dishContent,2)
                
                dishContentStr = char(dishContentStr,dishContent{k}{:});
            end
        end
        dishContentStr_Copy =  dishContentStr;
        % Delete < and >
        if(size(dishContentStr,2)>0)
            dishContentStr(:,1)=[];
            dishContentStr = reshape(strrep(reshape(dishContentStr,1,size(dishContentStr,1)*size(dishContentStr,2)), '<', ' '),size(dishContentStr,1),size(dishContentStr,2));
        end
        % Compare
        for j = 1:size(keywords,1)
            target = strtrim(keywords(j,:));
            for n = 1:size(dishContentStr,1)
                if (strfind(dishContentStr(n,:),target) ~= 0)
                   %disp(keywords)
                    switch(i)
                        case 1
                            breakfastContent = char(breakfastContent,strtrim(dishContentStr(n,:)));
                        case 2
                            lunchContent = char(lunchContent,strtrim(dishContentStr(n,:)));
                        case 3
                            dinnerContent = char(dinnerContent,strtrim(dishContentStr(n,:)));
                    end      
                end
            end
        end
    end
end
% breakfastContent = char(breakfastContent,lineContent);
% lunchContent = char(lunchContent,lineContent);
% dinnerContent = char(dinnerContent,lineContent);

welcomeContent = ['Dining Hall Menu Checker v' num2str(version) '  ' date ];
endContent = 'Replay this email to submit new keywords and suggestions.';
mailContent = char(welcomeContent,' ',' ',...
                    doubleLineContent,...
                    'Lunch Menu:',...
                    lunchContent,...
                    doubleLineContent,...
                    'Dinner Menu:',...
                    dinnerContent,...
                    doubleLineContent,...
                    'Breakfast Menu:',...
                    breakfastContent,...
                    doubleLineContent,...
                    endContent,' ',...
                    'Current keyword list:',...
                    keywords);
                

% Convert mailContent to vector(mailSent)
mailSent = '';
for i = 1:size(mailContent,1)
    strtrim(mailContent(i,:));
    mailSent = [mailSent,strtrim(mailContent(i,:)),char(13)];
end
                
                
                
% %%%%%%% https://www.google.com/settings/security/lesssecureapps less
% secure apps login.
mail = 'dininghallmenuchecker@gmail.com'; %
password = 'dhmchecker';  %
host='smtp.google.com';
mailTitle='DHMC Reminder 2.0 Daily Report';
%
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.host',host);
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');


for i = 2:size(subscripters,1)
    sendmail(strtrim(subscripters(i,:)),mailTitle,mailSent)
end

%exit;