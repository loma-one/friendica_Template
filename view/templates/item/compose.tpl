{{*
  * Copyright (C) 2010-2026, the Friendica project
  * SPDX-FileCopyrightText: 2010-2026 the Friendica project
  *
  * SPDX-License-Identifier: AGPL-3.0-or-later
  *}}

<style>
    .expandable-textarea {
        max-height: 300px !important;
        overflow-y: auto !important;
        resize: none;
    }

    @media (min-width: 992px) {
        .expandable-textarea {
            line-height: 1.6 !important;
            max-height: 50vh !important;
        }
    }

    .zen-active {
        position: fixed !important;
        top: 0 !important;
        left: 0 !important;
        width: 100vw !important;
        height: 100vh !important;
        z-index: 8000 !important;
        background: var(--background-color, #ffffff);
        padding: 40px 20px !important;
        overflow-y: auto !important;
        transform: none !important;
    }

    body.dark .zen-active { background: #1a1a1a !important; }

    .zen-active h2,
    .zen-active p:first-of-type,
    .zen-active #profile-jot-wrapper {
        max-width: 1200px !important;
        margin-left: auto !important;
        margin-right: auto !important;
    }

    .zen-active #comment-edit-text-{{$id}} {
        min-height: 55vh !important;
        max-height: 65vh !important;
    }

    .zen-active #jot-summary {
        min-height: 38px !important;
        max-height: 200px !important;
        margin-bottom: 20px;
    }

    body.zen-active-body .modal-backdrop { z-index: 10000 !important; }
    body.zen-active-body .modal { z-index: 10001 !important; }
    body.zen-active-body { overflow: hidden !important; }
</style>

<div class="generic-page-wrapper" id="jot-page-wrapper-{{$id}}">
    <h2>{{$l10n.compose_title}}</h2>
    {{if $l10n.always_open_compose}}
    <p>{{$l10n.always_open_compose nofilter}}</p>
    {{/if}}
    <div id="profile-jot-wrapper">
        <form class="comment-edit-form" data-item-id="{{$id}}" id="comment-edit-form-{{$id}}" action="compose/{{$type}}" method="post">
            <input type="hidden" name="post_id_random" value="{{$rand_num}}" />
            <input type="hidden" name="post_type" value="{{$posttype}}" />
            <input type="hidden" name="wall" value="{{$wall}}" />

            <div id="jot-title-wrap">
                <input type="text" name="title" id="jot-title" class="jothidden jotforms form-control" placeholder="{{$l10n.placeholdertitle}}" title="{{$l10n.placeholdertitle}}" value="{{$title}}" tabindex="1" dir="auto" />
            </div>

            {{if $l10n.placeholdersummary}}
            <div id="jot-summary-wrap">
                <textarea name="summary" id="jot-summary" class="jothidden jotforms form-control expandable-textarea" placeholder="{{$l10n.placeholdersummary}}" title="{{$l10n.placeholdersummary}}" rows="1" tabindex="2" dir="auto" style="min-height: 38px; height: 38px;">{{$summary}}</textarea>
            </div>
            {{/if}}

            {{if $l10n.placeholdercategory}}
                <div id="jot-category-wrap">
                    <input name="category" id="jot-category" class="jothidden jotforms form-control" type="text" placeholder="{{$l10n.placeholdercategory}}" title="{{$l10n.placeholdercategory}}" value="{{$category}}" tabindex="3" dir="auto" />
                </div>
            {{/if}}

            <div class="comment-edit-bb-{{$id}} btn-toolbar clearfix" role="toolbar">
                <div class="btn-group">
                    <button type="button" class="btn btn-default bb-img" aria-label="{{$l10n.edimg}}" title="{{$l10n.edimg}}" data-role="insert-formatting" data-bbcode="img" data-id="{{$id}}" tabindex="4">
                        <i class="fa fa-picture-o"></i>
                    </button>
                    <button type="button" class="btn btn-default bb-attach" aria-label="{{$l10n.edattach}}" title="{{$l10n.edattach}}" ondragenter="return commentLinkDrop(event, {{$id}});" ondragover="return commentLinkDrop(event, {{$id}});" ondrop="commentLinkDropper(event);" onclick="commentGetLink({{$id}}, '{{$l10n.prompttext}}');" tabindex="5">
                        <i class="fa fa-paperclip"></i>
                    </button>
                    <button type="button" id="button_emojipicker" class="btn btn-default emojis" aria-label="{{$l10n.edemojis}}" title="{{$l10n.edemojis}}" tabindex="6">
                      <i class="fa fa-smile-o"></i>
                    </button>
                    <button type="button" class="btn btn-default bb-zen" aria-label="Zen-Modus" title="Zen-Modus" onclick="toggleZenMode({{$id}});" tabindex="21">
                        <i class="fa fa-expand"></i>
                    </button>
                </div>

                <div class="pull-right">
                    <div class="btn-group">
                        <button type="button" class="btn btn-default bb-url" aria-label="{{$l10n.edurl}}" title="{{$l10n.edurl}}" onclick="insertFormatting('url',{{$id}});" tabindex="7">
                            <i class="fa fa-link"></i>
                        </button>
                        <button type="button" class="btn btn-default bb-url" aria-label="{{$l10n.edembed}}" title="{{$l10n.edembed}}" onclick="insertFormatting('embed',{{$id}});" tabindex="8">
                            <i class="fa fa-play"></i>
                        </button>
                        <button type="button" class="btn btn-default underline" aria-label="{{$l10n.eduline}}" title="{{$l10n.eduline}}" onclick="insertFormatting('u',{{$id}});" tabindex="9">
                            <i class="fa fa-underline"></i>
                        </button>
                        <button type="button" class="btn btn-default italic" aria-label="{{$l10n.editalic}}" title="{{$l10n.editalic}}" onclick="insertFormatting('i',{{$id}});" tabindex="10">
                            <i class="fa fa-italic"></i>
                        </button>
                        <button type="button" class="btn btn-default bold" aria-label="{{$l10n.edbold}}" title="{{$l10n.edbold}}" onclick="insertFormatting('b',{{$id}});" tabindex="11">
                            <i class="fa fa-bold"></i>
                        </button>
                    </div>
                    <div class="btn-group">
                        <button type="button" class="btn btn-default quote" aria-label="{{$l10n.edquote}}" title="{{$l10n.edquote}}" onclick="insertFormatting('quote',{{$id}});" tabindex="12">
                            <i class="fa fa-quote-left"></i>
                        </button>
                        <button type="button" class="btn btn-default bb-url" aria-label="{{$l10n.contentwarn}}" title="{{$l10n.contentwarn}}" onclick="insertFormatting('abstract',{{$id}});" tabindex="13">
                            <i class="fa fa-eye"></i>
                        </button>
                        <button type="button" class="btn btn-default code" aria-label="{{$l10n.edcode}}" title="{{$l10n.edcode}}" onclick="insertFormatting('code',{{$id}});" tabindex="14">
                            <i class="fa fa-code"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div id="dropzone-{{$id}}" class="dropzone">
                <p>
                    <textarea id="comment-edit-text-{{$id}}" class="comment-edit-text form-control text-autosize expandable-textarea" name="body" placeholder="{{$l10n.default}}" rows="12" tabindex="3" dir="auto" onkeydown="sendOnCtrlEnter(event, 'comment-edit-submit-{{$id}}')">{{$body}}</textarea>
                </p>
            </div>

            <div class="comment-edit-submit-wrapper clearfix">
                {{if $type == 'post'}}
                    <div id="compose-additional-settings-location">
                        <button type="button" name="permissions" class="btn btn-default" id="toggle-permissions" title="{{$l10n.toggle_permissions_tooltip}}" onclick="togglePermissions()" tabindex="5">
                            <i class="fa fa-ellipsis-h"></i> {{$l10n.toggle_permissions}}
                        </button>
                        <input type="text" name="location" class="form-control" id="jot-location" value="{{$location}}" placeholder="{{$l10n.location_set}}" tabindex="6" style="width: auto; display: inline-block;" />
                        <button type="button" class="btn btn-default" id="profile-location" tabindex="7">
                            <i class="fa fa-map-marker" aria-hidden="true"></i>
                        </button>
                    </div>
                {{/if}}
                <div>
                    <span role="presentation" id="profile-rotator-wrapper">
                        <img role="presentation" id="profile-rotator" src="images/rotator.gif" style="display: none;" />
                    </span>
                    <span role="presentation" id="character-counter" class="grey text-info"></span>
                    <button type="button" class="btn btn-default" onclick="preview_comment_toggle({{$id}}, '{{$l10n.preview}}');" id="comment-edit-preview-link-{{$id}}" tabindex="8">
                        <i class="fa fa-eye"></i> <span id="preview-btn-text-{{$id}}">{{$l10n.preview}}</span>
                    </button>
                    <button type="submit" class="btn btn-primary" id="comment-edit-submit-{{$id}}" name="submit" tabindex="9"><i class="fa fa-paper-plane"></i> {{$l10n.submit}}</button>
                </div>
            </div>

            <div id="comment-edit-preview-{{$id}}" class="comment-edit-preview" style="display:none;"></div>

            <!-- Modal -->
            <div class="modal fade" id="permissions-modal-{{$id}}" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">{{$l10n.visibility_title}}</h4>
                        </div>
                        <div class="modal-body">
                            {{if $type == 'post'}}
                                {{$acl_selector nofilter}}
                                <div class="jotplugins">{{$jotplugins nofilter}}</div>
                                <div class="field checkbox" style="margin-top: 15px;">
                                    <input type="checkbox" name="sensitive" id="id_sensitive" value="1" {{if $sensitive.value}}checked="checked"{{/if}}>
                                    <label for="id_sensitive" style="font-weight: normal; margin-left: 5px;">Sensitive post</label>
                                </div>
                                {{if $scheduled_at}}{{$scheduled_at nofilter}}{{/if}}
                            {{else}}
                                <input type="hidden" name="circle_allow" value="{{$circle_allow}}"/>
                                <input type="hidden" name="contact_allow" value="{{$contact_allow}}"/>
                            {{/if}}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    dzFactory.setupDropzone('#dropzone-{{$id}}', 'comment-edit-text-{{$id}}');

    function resizeTextarea(el) {
        if (!el) return;
        el.style.height = "auto";
        if (el.id === 'jot-summary') {
            el.style.height = Math.max(38, el.scrollHeight) + "px";
        } else {
            el.style.height = el.scrollHeight + "px";
        }
    }

    function toggleZenMode(id) {
        const wrapper = document.getElementById('jot-page-wrapper-' + id);
        const isZen = wrapper.classList.toggle('zen-active');
        document.body.classList.toggle('zen-active-body');

        if (isZen) {
            window.dispatchEvent(new Event('resize'));
            const escHandler = (e) => {
                if (e.key === "Escape") {
                    if (document.querySelector('.modal.in, .modal.show')) return;
                    if (wrapper.classList.contains('zen-active')) {
                        toggleZenMode(id);
                        document.removeEventListener('keydown', escHandler);
                    }
                }
            };
            document.addEventListener('keydown', escHandler);
        }

        resizeTextarea(document.getElementById('jot-summary'));
        resizeTextarea(document.getElementById('comment-edit-text-' + id));
    }

    function togglePermissions() {
        const modal = $('#permissions-modal-{{$id}}');
        modal.appendTo('body').modal('show');
    }

    $(document).on('hidden.bs.modal', '#permissions-modal-{{$id}}', function () {
        $(this).appendTo('#comment-edit-form-{{$id}}');
    });

    function preview_comment_toggle(id, originalText) {
        var previewPane = document.getElementById('comment-edit-preview-' + id);
        var btnTextSpan = document.getElementById('preview-btn-text-' + id);
        var mainTextarea = document.getElementById('comment-edit-text-' + id);
        var summaryField = document.getElementById('jot-summary');

        if (previewPane.style.display === 'block') {
            previewPane.style.display = 'none';
            btnTextSpan.textContent = originalText;
        } else {
            var originalBody = mainTextarea.value;
            if (summaryField && summaryField.value.trim() !== "") {
                mainTextarea.value = "[b][i]" + summaryField.value.trim() + "[/i][/b]\n\n" + originalBody;
            }
            preview_comment(id);
            mainTextarea.value = originalBody;
            btnTextSpan.textContent = "Close preview";
            previewPane.style.display = 'block';
        }
    }

    var formSubmitting = false;

    document.addEventListener("DOMContentLoaded", function() {
        const textareas = document.querySelectorAll(".expandable-textarea");

        textareas.forEach(function(textarea) {
            const savedContent = localStorage.getItem(`comment-edit-text-${textarea.id}`);
            const lastSaved = localStorage.getItem(`last-saved-${textarea.id}`);
            if (savedContent && lastSaved && (new Date().getTime() - parseInt(lastSaved, 10) <= 600000)) {
                textarea.value = savedContent;
            }

            textarea.addEventListener("input", function() { resizeTextarea(this); });
            resizeTextarea(textarea);
        });

        setInterval(() => {
            if (formSubmitting) return;
            textareas.forEach(textarea => {
                if (textarea.value.trim() !== "") {
                    localStorage.setItem(`comment-edit-text-${textarea.id}`, textarea.value);
                    localStorage.setItem(`last-saved-${textarea.id}`, new Date().getTime().toString());
                }
            });
        }, 5000);
    });

    document.getElementById('comment-edit-form-{{$id}}').addEventListener('submit', function() {
        formSubmitting = true;
        document.querySelectorAll(".expandable-textarea").forEach(textarea => {
            localStorage.removeItem(`comment-edit-text-${textarea.id}`);
            localStorage.removeItem(`last-saved-${textarea.id}`);
        });
    });

    window.addEventListener("beforeunload", function (event) {
        if (!formSubmitting && document.getElementById('comment-edit-text-{{$id}}').value.trim().length > 0) {
            event.returnValue = 'Discard changes?';
        }
    });
</script>
